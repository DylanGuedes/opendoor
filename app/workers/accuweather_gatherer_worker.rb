require 'mechanize'

class AccuweatherGathererWorker
  include Sidekiq::Worker

  @@cron_scheduled = false

  def self.cron_running
    @@cron_scheduled
  end

  def self.turn_on
    @@cron_scheduled = true
  end

  def fetch_accuweather_index
    url_accuweather = "http://www.accuweather.com/pt/br/brazil-weather"
    agent = Mechanize.new
    config = File.open("#{project_path}neighborhood").read
    weather = agent.get(url_accuweather)
    weather.forms[1]
  end

  def fetch_accuweather_resource(form, neighborhood)
    form['s'] = "#{neighborhood}, São Paulo"
    form.submit
  end

  def project_path
    project_path = "./"
    project_path = ARGV[0] unless ARGV[0].nil?
  end

  def load_neighborhood_file
    File.open("#{project_path}neighborhood").read
  end

  def fetch_resource_data_from_response(response, neighborhood)
    if !response.at('.results-list h3').nil?
      if response.at('.results-list h3').text == "Vários locais encontrados:"
        location = response.link_with(text: "#{neighborhood}, São Paulo, BR ")
        response = location.click
      end
    end

    link = response.link_with(text: 'Tempo atual')
    page = link.click
    temperature = page.at('#detail-now .forecast .info .temp .large-temp').text
    temperature = temperature.gsub!(/[^0-9]/, '').to_i

    thermal_sensation = page.at('#detail-now .forecast .info .temp .small-temp').text
    thermal_sensation = thermal_sensation.gsub!(/[^0-9]/, '').to_i

    stats = page.at('#detail-now .more-info .stats').text.strip
    stats = stats.gsub!(/\:/, '')
    stats = stats.split(/\s/).reject(&:empty?)

    humidity_index = stats.index('Humidade') + 1
    pressure_index = stats.index('Pressão') + 1
    uv_index_index = stats.index('UV') + 1
    cloud_cover_index = stats.index('nuvens') + 1
    ceilling_index = stats.index('Teto') + 1
    dew_point_index = stats.index('orvalho') + 1
    visibility_index = stats.index('Visibilidade') + 1

    wind_speed = stats[3].to_i
    humidity = stats[humidity_index]
    pressure = stats[pressure_index].to_f
    uv_index = stats[uv_index_index]
    cloud_cover = stats[cloud_cover_index]
    ceilling = stats[ceilling_index]
    dew_point = stats[dew_point_index]
    visibility = stats[visibility_index]

    timestamp = Time.now.getutc.to_s
    {
      temperature: temperature,
      thermal_sensation: thermal_sensation,
      neighborhood: neighborhood,
      wind_speed: wind_speed,
      pressure: pressure,
      humidity: humidity,
      cloud_cover: cloud_cover,
      uv_index: uv_index,
      ceilling: ceilling,
      dew_point: dew_point,
      visibility: visibility,
      timestamp: timestamp
    }
  end

  def perform(platform_id)
    form = fetch_accuweather_index

    config_file = load_neighborhood_file
    config_file.each_line do |neighborhood|
      neighborhood = neighborhood.strip
      response = fetch_accuweather_resource(form, neighborhood)
      doc = fetch_resource_data_from_response(response, neighborhood)
      attrs = {
        worker_uuid: doc[:neighborhood],
        platform_id: platform_id
      }

      resource = Weather.find_by(attrs)
      if resource and resource.uuid
        new_data = {}
        new_data[:weather] = [
          {
            neighborhood: neighborhood,
            temperature: doc[:temperature],
            thermal_sensation: doc[:thermal_sensation],
            wind_speed: doc[:wind_speed],
            humidity: doc[:humidity],
            pressure: doc[:pressure],
            timestamp: doc[:timestamp],
            cloud_cover: doc[:cloud_cover],
            uv_index: doc[:uv_index],
            ceilling: doc[:ceilling],
            dew_point: doc[:dew_point],
            visibility: doc[:visibility]
          }
        ]
        update_resource_data(resource, {data: new_data})
      else
        create_resource(doc, platform_id)
      end
    end
  end

  def update_resource_data(resource, new_data)
    resource.send_data(new_data)
  end

  def create_resource(doc, platform_id)
    neighborhood = doc[:neighborhood]
    coords = Geocoder.coordinates("#{neighborhood}, São Paulo")
    unless coords
      coords = Geocoder.coordinates("São Paulo") # if region isnt available..
    end

    resource_data = {
      worker: 2,
      worker_uuid: neighborhood,
      lat: coords[0],
      lon: coords[1],
      status: "active",
      region: neighborhood,
      platform_id: platform_id,
      neighborhood: neighborhood
    }
    res = Weather.create(resource_data)
    res.fetch_or_register
  end
end

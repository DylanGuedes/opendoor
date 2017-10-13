require 'mechanize'

class CetesbGathererWorker
  include Sidekiq::Worker

  def fetch_cetesb_page
    url_cetesb = "http://sistemasinter.cetesb.sp.gov.br/Ar/php/ar_resumo_hora.php"
    agent = Mechanize.new
    page = agent.get(url_cetesb)
    page.encoding = "utf-8"
    page.search("table tr td table.font01")[0]
  end

  def fetch_quality(data)
    data = data[1].element_children[0].attributes["src"].value

    case data
    when "../mapa_qualidade/imagens/novo/quadro1.gif"
      'boa'
    when "../mapa_qualidade/imagens/novo/quadro2.gif"
      'moderada'
    when "../mapa_qualidade/imagens/novo/quadro3.gif"
      'ruim'
    when "../mapa_qualidade/imagens/novo/quadro4.gif"
      'muito ruim'
    when "../mapa_qualidade/imagens/novo/quadro5.gif"
      'péssima'
    end
  end

  def fetch_region(data)
    data[0].text
  end

  def fetch_polluting_index(data)
    data[2].text
  end

  def fetch_polluting(data)
    data[3].text
  end

  def perform(collector_id, platform_id)
    cetesb_data = fetch_cetesb_page

    cetesb_data.element_children.each do |line|
      next if line.element_children.empty?

      data = line.element_children

      region = fetch_region(data)
      index = fetch_polluting_index(data)
      polluting = fetch_polluting(data)
      quality = fetch_quality(data)
      timestamp = Time.now.getutc.to_s

      attrs = {
        worker_uuid: region,
        platform_id: platform_id
      }
      # if the resource is already present, do not register a new one
      resource = AirQuality.find_by(attrs)

      if resource
        new_data = {
          air_quality: [{value: quality, timestamp: timestamp}],
          polluting: [{value: polluting, timestamp: timestamp}],
          polluting_index: [{value: index, timestamp: timestamp}]
        }
        update_resource_data(resource, new_data)
      else
        create_resource(region, platform_id)
      end
    end
  end

  def update_resource_data(resource, new_data)
    resource.send_data(new_data)
  end

  def create_resource(region, platform_id)
    resource_data = {
      worker: AirQuality.workers[:cetesb_gatherer_worker],
      worker_uuid: region,
      lat: -23.559616, # TODO: fakedata
      lon: -1.55, # TODO: fakedata
      status: "active",
      region: region,
      platform_id: platform_id
    }
    res = AirQuality.create(resource_data)
    res.fetch_or_register
  end
end

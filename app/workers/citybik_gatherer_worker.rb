class CitybikGathererWorker
  include Sidekiq::Worker

  @@cron_scheduled = false

  def self.cron_running
    @@cron_scheduled
  end

  def self.turn_on
    @@cron_scheduled = true
  end

  NETWORK_IDS = ["bikesampa"]
  BASE_URL = "https://api.citybik.es/v2/"

  def perform(platform_id)
    NETWORK_IDS.each do |ni|
      url = BASE_URL + "/networks/#{ni}"
      response = RestClient.get(url)
      network = JSON.parse(response)["network"]

      network["stations"].each do |station|
        attrs = {
          platform_id: platform_id,
          worker_uuid: station["id"]
        }

        puts "Loading resource #{attrs}..."
        resource = BikeStation.where(attrs)

        case
        when resource.count == 1
          resource = resource.first

          new_data = {}
          new_data[:open] = [
            {
              status: station["extra"]["status"]=="open",
              timestamp: Time.now.getutc.to_s
            }
          ]

          new_data[:slots_monitoring] = [
            {

              timestamp: Time.now.getutc.to_s,
              free_bikes: station["free_bikes"],
              bike_slots: station["empty_slots"]
            }
          ]

          update_resource_data(resource, {data: new_data})
        when resource.count > 1
          raise "Multiple resources for worker_uuid #{station["id"]}!"
        when resource.count < 1
          create_resource(station, platform_id)
        end
      end
    end
  end

  def update_resource_data(resource, new_data)
    resource.send_data(new_data)
  end

  def create_resource(station, platform_id)
    resource_data = {
      worker: AirQuality.workers[:cetesb_gatherer_worker],
      worker_uuid: station["id"],
      lat: station["latitude"],
      lon: station["longitude"],
      status: "active",
      address: station["extra"]["address"],
      platform_id: platform_id,
      bike_station_uuid: station["id"]
    }
    res = BikeStation.new(resource_data)
    if res.save
      res.fetch_or_register
    else
      raise "BikeStation not saved: #{station["id"]}"
    end
  end
end

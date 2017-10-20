class AirQuality < ApplicationRecord
  belongs_to :platform
  validates :platform, presence: true

  include InterscityResource

  def fetch_from_platform
    platform_url = self.platform.url
    url = platform_url + "/catalog/resources/#{self.uuid}"
    response = RestClient.get(url)
    response ? true : false
  end

  def self.capabilities
    [
      {title: "air-quality", typ: "sensor", description: 'air quality of a given region'},
      {title: "polluting-index", typ: "sensor", description: 'polluting index..'},
      {title: "polluting", typ: "sensor", description: 'type of polluting'}
    ]
  end

  def normalized_registration_data
    {
      lat: self.lat,
      lon: self.lon,
      description: "#{self.region} air quality",
      capabilities: ["air-quality", "polluting-index", "polluting"],
      status: "active"
    }
  end

  # Extract only required attributes to look for a instance of this resource.
  def fetch entry
    {
      worker_uuid: entry[:region],
      platform_uuid: entry[:platform_id]
    }
  end

  def mount_data_from entry
    data = {}
    data[:air_quality] = [
      {
        air_quality: entry[:quality],
        polluting: entry[:polluting],
        polluting_index: entry[:index],
        timestamp: entry[:timestamp]
      }
    ]
  end

  def mount_resource entry
    {
      worker: AirQuality.workers[:cetesb_gatherer_worker],
      worker_uuid: entry[:region],
      lat: -23.559616, # TODO: fakedata
      lon: -1.55, # TODO: fakedata
      status: "active",
      region: entry[:region],
      platform_id: entry[:platform_id]
    }
  end
end

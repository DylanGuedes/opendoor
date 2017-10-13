class AirQuality < ApplicationRecord
  belongs_to :platform
  include InterscityResource

  def fetch_from_platform
    platform_url = self.platform.url
    url = platform_url + "/catalog/resources/#{self.uuid}"
    response = RestClient.get(url)
    puts response
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
      capabilities: AirQuality.capabilities,
      status: "active"
    }
  end

  def normalized_update_data
    {
      air_quality: [{value: self.quality, timestamp: self.timestamp}],
      polluting_index: [{value: self.polluting_index, timestamp: self.timestamp}],
      polluting: [{value: self.polluting, timestamp: self.timestamp}]
    }
  end

end

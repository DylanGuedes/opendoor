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
end

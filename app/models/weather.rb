class Weather < ApplicationRecord
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
      {
        title: "weather",
        typ: "sensor",
        description: %{
         Weather of a given region. Meta-data:
         Thermal sensation => Fahrenheit,
         Wind speed => mph,
         Humidity => %, Pressure => pol,
         Pressure => pol, cloud_cover => %,
         uv_index => number, ceilling => ft,
         dew_point => Fahrenheit, Visibility => mi'
        }
      }
    ]
  end

  def normalized_registration_data
    {
      lat: self.lat,
      lon: self.lon,
      description: "#{self.neighborhood} weather",
      capabilities: [
        'weather'
      ],
      status: "active",
      neighborhood: self.neighborhood,
      state: self.neighborhood,
      country: self.neighborhood
    }
  end

  # Extract only required attributes to look for a instance of this resource.
  def self.fetch entry
    {
      worker_uuid: entry[:neighborhood],
      platform_id: entry[:platform_id]
    }
  end

  def self.mount_data_from entry
    data = {}
    data[:weather] = [
      {
        temperature: entry[:temperature],
        timestamp: DateTime.now.to_s
      },
      {
        thermal_sensation: entry[:index],
        timestamp: DateTime.now.to_s
      },
      {
        wind_speed: entry[:polluting],
        timestamp: DateTime.now.to_s
      },
      {
        humidity: entry[:humidity],
        timestamp: DateTime.now.to_s
      },
      {
        pressure: entry[:pressure],
        timestamp: DateTime.now.to_s
      },
      {
        neighborhood: entry[:neighborhood],
        timestamp: DateTime.now.to_s
      }
    ]
    data
  end

  def self.mount_resource entry
    coords = Geocoder.coordinates(entry[:neighborhood])
    {
      worker: AirQuality.workers[:cetesb_gatherer_worker],
      worker_uuid: entry[:neighborhood],
      lat: coords[0],
      lon: coords[1],
      status: "active",
      region: entry[:neighborhood],
      platform_id: entry[:platform_id]
    }
  end

  def self.collection
    :weather
  end
end

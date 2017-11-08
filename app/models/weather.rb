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
      {title: "temperature", typ: "sensor", description: 'temperature of a given region, in fahrenheit'},
      {title: "thermal_sensation", typ: "sensor", description: 'thermal sensation of a given region, in fahrenheit'},
      {title: "wind_speed", typ: "sensor", description: 'wind speed of a given region, in mph'},
      {title: 'humidity', typ: 'sensor', description: 'humidity of a given region, in percentage'},
      {title: 'pressure', typ: 'sensor', description: 'pressure of a given region, in pol'},
      {title: 'neighborhood', typ: 'sensor', description: 'neighborhood of this resource'},
      {title: 'cloud_cover', typ: 'sensor', description: 'cloud cover of a given region, in percentage'},
      {title: 'uv_index', typ: 'sensor', description: 'uv index of a given region'},
      {title: 'ceilling', typ: 'sensor', description: 'ceilling of a given region, in ft'},
      {title: 'dew_point', typ: 'sensor', description: 'dew point of a given region, in fahrenheit'},
      {title: 'visibility', typ: 'sensor', description: 'visibility of a given region, in mi'}
    ]
  end

  def normalized_registration_data
    {
      lat: self.lat,
      lon: self.lon,
      description: "#{self.neighborhood} weather",
      capabilities: [
        'temperature',
        'thermal_sensation',
        'wind_speed',
        'humidity',
        'pressure',
        'neighborhood',
        'cloud_cover',
        'uv_index',
        'ceilling',
        'dew_point',
        'visibility'
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
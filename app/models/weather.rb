class Weather < ApplicationRecord
  belongs_to :platform
  validates :platform, presence: true
  validates :lat, presence: true
  validates :lon, presence: true
  validates :worker_uuid, presence: true
  validate :worker_uuid_should_be_equal_to_identifier_attr

  include InterscityResource

  def worker_uuid_should_be_equal_to_identifier_attr
    unique_attr = Weather.identifier_attr
    if worker_uuid != self.send(unique_attr)
      errors.add(:worker_uuid, "should be equal to #{unique_attr}")
    end
  end

  def equal_to_unique_attr?
    worker_uuid == send(Weather.identifier_attr)
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
      description: "#{self.worker_uuid} weather",
      capabilities: [
        'weather'
      ],
      status: "active",
      neighborhood: self.worker_uuid,
      state: self.worker_uuid,
      country: self.worker_uuid
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
        thermal_sensation: entry[:index],
        wind_speed: entry[:polluting],
        humidity: entry[:humidity],
        pressure: entry[:pressure],
        neighborhood: entry[:neighborhood],
        timestamp: DateTime.now.to_s
      }
    ]
    data
  end

  def self.mount_resource entry
    coords = Geocoder.coordinates(entry[:neighborhood])
    if not coords
      raise "Geocoder didn't solved #{entry[:neighborhood]}"
    end

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

  def self.identifier_attr
    :region
  end
end

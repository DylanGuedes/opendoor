class BikeStation < ApplicationRecord
  belongs_to :platform
  validates :platform, presence: true
  validates :worker_uuid, presence: true
  validates :bike_station_uuid, presence: true
  validates :lat, presence: true
  validates :lon, presence: true

  include InterscityResource

  def self.capabilities
    [
      {
        title: 'open',
        typ: 'sensor',
        description: %{
          Bike station status
        }
      },
      {
        title: 'slots_monitoring',
        typ: 'sensor',
        description: %{
          Number of available bike slots and free bikes.
        }
      }
    ]
  end

  def normalized_registration_data
    {
      lat: self.lat,
      lon: self.lon,
      description: "bike station located in #{self.address}",
      capabilities: ['open', 'slots_monitoring'],
      status: 'active'
    }
  end

  def self.fetch entry
    {
      worker_uuid: entry["bike_station_uuid"],
      platform_id: entry["platform_id"]
    }
  end

  def self.mount_data_from entry
    data = {}
    data[:bike_station] = [
      {
        slots: entry["slots"],
        free_bikes: entry["free_bikes"],
        address: entry["address"],
        bike_station_uuid: entry["bike_station_uuid"],
        status: entry["status"],
        timestamp: DateTime.now.to_s
      }
    ]
    data
  end

  def self.mount_resource entry
    {
      worker: 1,
      worker_uuid: entry["bike_station_uuid"],
      lat: entry["lat"],
      lon: entry["lon"],
      bike_station_uuid: entry["bike_station_uuid"],
      platform_id: entry["platform_id"]
    }
  end

  def self.collection
    :bike_station
  end
end

class StaticEntity < ApplicationRecord
  belongs_to :platform
  validates :platform, presence: true
  validates :worker_uuid, presence: true
  validates :lat, presence: true
  validates :lon, presence: true

  include InterscityResource

  def self.capabilities
    [
      {title: "static", typ: "sensor", description: 'static data'},
    ]
  end

  def normalized_registration_data
    {
      lat: self.lat,
      lon: self.lon,
      description: "#{self.worker_uuid} Geosampa static data",
      capabilities: ['static'],
      status: "active",
      neighborhood: self.worker_uuid,
      state: self.worker_uuid,
      country: self.worker_uuid
    }
  end

  # Extract only required attributes to look for a instance of this resource.
  def self.fetch entry
    {
      worker_uuid: entry[:name],
      platform_id: entry[:platform_id]
    }
  end

  def self.mount_data_from entry
    data = {}
  end

  def self.mount_resource entry
    x,y = entry[:coordinates]
    puts "X,Y: #{x},#{y}"
    coords = GeoUtm::UTM.new('23K', x, y).to_lat_lon

    {
      worker_uuid: entry[:name],
      lat: coords.lat,
      lon: coords.lon,
      status: "active",
      platform_id: entry[:platform_id]
    }
  end

  def self.collection
    :static_entity
  end

  def update_location
    new_data = {}
    new_data[:bus_station] = [
      {
        latitude: self.lat,
        longitude: self.lon
      }
    ]

    send_data({data: new_data})
  end
end

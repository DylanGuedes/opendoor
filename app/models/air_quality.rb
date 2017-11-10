class AirQuality < ApplicationRecord
  belongs_to :platform
  validates :platform, presence: true
  validates :worker_uuid, presence: true
  validates :lat, presence: true
  validates :lon, presence: true

  include InterscityResource

  def fetch_from_platform
    if not self.uuid
      raise "Resource from #{self.worker_uuid} doesn't have an uuid."
    end

    platform_url = self.platform.url
    url = platform_url + "/catalog/resources/#{self.uuid}"
    RestClient.get(url)
  end

  def self.capabilities
    [
      {
        title: 'air_quality',
        typ: 'sensor',
        description: %{
           Air quality of a given region. Meta-data:
           Quality => Overall air quality,
           Polluting Index => Polluting index, a number based on polluting type,
           Polluting Type => String
        }
      }
    ]
  end

  def normalized_registration_data
    {
      lat: self.lat,
      lon: self.lon,
      description: "#{self.worker_uuid} air quality",
      capabilities: ["air_quality"],
      status: "active",
      neighborhood: self.worker_uuid,
      state: self.worker_uuid,
      country: self.worker_uuid
    }
  end

  # Extract only required attributes to look for a instance of this resource.
  def self.fetch entry
    if not entry[:region] or not entry[:platform_id]
      raise "Missing params region or platform_id!"
    end

    {
      worker_uuid: entry[:region],
      platform_id: entry[:platform_id]
    }
  end

  def self.mount_data_from entry
    data = {}
    data[:air_quality] = [
      {
        air_quality: entry[:quality],
        timestamp: DateTime.now.to_s
      },
      {
        polluting_index: entry[:index],
        timestamp: DateTime.now.to_s
      },
      {
        polluting: entry[:polluting],
        timestamp: DateTime.now.to_s
      }
    ]
    data
  end

  def self.mount_resource entry
    coords = Geocoder.coordinates(entry[:region])
    if not coords
      raise "Geocoder didn't solved #{entry[:region]}"
    end

    {
      worker: AirQuality.workers[:cetesb_gatherer_worker],
      worker_uuid: entry[:region],
      lat: coords[0],
      lon: coords[1],
      status: "active",
      region: entry[:region],
      platform_id: entry[:platform_id]
    }
  end

  def self.collection
    :air_quality
  end
end

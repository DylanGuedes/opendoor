class FreeWifiStation < ApplicationRecord
  belongs_to :platform
  validates :platform, presence: true
  validates :worker_uuid, presence: true
  validates :lat, presence: true
  validates :lon, presence: true

  include InterscityResource

  def self.identifier_attr
    "wf_nome"
  end

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
        title: "static",
        typ: "sensor",
        description: %{
          Static entity.
        }
      }
    ]
  end

  def normalized_registration_data
    {
      lat: self.lat,
      lon: self.lon,
      description: "#{self.worker_uuid} Wifi Station",
      capabilities: [
        'static'
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

  def self.mount_data_from entry=nil
    data = {}
    data[:static] = [
      {
        type: "free_wifi_station",
        timestamp: DateTime.now.to_s
      }
    ]
    data
  end

  def self.mount_resource entry
    {
      worker: AirQuality.workers[:cetesb_gatherer_worker],
      worker_uuid: entry[:name],
      lat: entry[:coordinates][0],
      lon: entry[:coordinates][1],
      status: "active",
      platform_id: entry[:platform_id]
    }
  end

  def self.collection
    :free_wifi_station
  end

  def update_location
    send_data({data: self.class.mount_data_from})
  end
end

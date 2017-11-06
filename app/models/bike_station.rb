class BikeStation < ApplicationRecord
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
      {title: 'slots', typ: 'sensor', description: 'the number of slots'},
      {title: 'free-bikes', typ: 'sensor', description: 'the number of bikes available to hire'},
      # address field needs revision, it is here because of the legacy code
      {title: 'address', typ: 'sensor', description: 'the bike station address'},
      # external_uid field needs revision, it is here because legacy code
      {title: 'bike-station-uuid', typ: 'sensor', description: 'bike station identification extracted from external data source'},
      {title: 'status', typ: 'sensor', description: 'information about the bike station'}
    ]
  end

  def normalized_registration_data
    {
      lat: self.lat,
      lon: self.lon,
      description: "#{self.bike_station_uuid} bike station",
      capabilities: ['slots', 'free-bikes', 'address', 'bike-station-uuid', 'status'],
      status: 'active'
    }
  end

  def self.fetch entry
    {
      worker_uuid: entry[:bike_station_uuid],
      platform_id: entry[:platform_id]
    }
  end

  def self.mount_data_from entry
    data = {}
    data[:bike_station] = [
      { slots: entry[:slots], timestamp: DateTime.now.to_s },
      { free_bikes: entry[:free_bikes], timestamp: DateTime.now.to_s },
      { address: entry[:address], timestamp: DateTime.now.to_s },
      { bike_station_uuid: entry[:bike_station_uuid], timestamp: DateTime.now.to_s },
      { status: entry[:status], timestamp: DateTime.now.to_s }
    ]
  end

  def self.mount_resource entry
    {
      worker: BikeStation.workers[:citybik_gatherer_worker],
      worker_uuid: entry[:bike_station_uuid],
      lat: entry[:lat],
      lon: entry[:lon],
      bike_station_uuid: entry[:bike_station_uuid],
      platform_id: entry[:platform_id]
    }
  end

  def self.collection
    :bike_station
  end
end

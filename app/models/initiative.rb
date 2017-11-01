class Initiative < ApplicationRecord
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
        title: "responsible",
        typ: "sensor",
        description: 'Responsible for this initiative'
      },
      {
        title: "responsible_email",
        typ: "sensor",
        description: 'Responsible email'
      },
      {
        title: "responsible_phone",
        typ: "sensor",
        description: 'Phone of responsible'
      }
    ]
  end

  def normalized_registration_data
    {
      lat: self.lat,
      lon: self.lon,
      description: "#{self.name} initiative",
      capabilities: ["responsible", "responsible_email", "responsible_phone"],
      status: "active",
      neighborhood: self.address,
      state: self.state,
      country: self.city
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
    data[:responsible] = [
      {
        responsible: entry[:responsible],
        timestamp: DateTime.now.to_s
      },
      {
        responsible_email: entry[:responsible_email],
        timestamp: DateTime.now.to_s
      },
      {
        responsible_name: entry[:responsible_name],
        timestamp: DateTime.now.to_s
      }
    ]
    data
  end

  def self.mount_resource entry
    coords = Geocoder.coordinates("#{entry[:city]}, #{entry[:address]}")
    {
      worker_uuid: entry[:name],
      lat: coords[0],
      lon: coords[1],
      status: "active",
      region: "#{entry[:city]}, #{entry[:address]}",
      platform_id: entry[:platform_id]
    }
  end

  def self.collection
    :initiative
  end
end

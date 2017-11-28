class News < ApplicationRecord
  belongs_to :platform
  validates :platform, presence: true
  validates :worker_uuid, presence: true
  validates :post_id, presence: true
  validates :lat, presence: true
  validates :lon, presence: true

  include InterscityResource

  def self.capabilities
    [
      {
        title: 'news',
        typ: 'sensor',
        description: %{
          News from a given region. Meta-data:
          Title => News' title,
          Author => News' Author,
          Content => New' content,
          Image => News' image
        }
      },
    ]
  end

  def normalized_registration_data
    {
      lat: self.lat,
      lon: self.lon,
      description: "#{self.worker_uuid} news",
      capabilities: ['post'],
      status: 'active'
    }
  end

  def self.fetch entry
    if not entry[:post_id] or not entry[:platform_id]
      raise 'Missing params post_id or platform_id'
    end

    {
      worker_uuid: entry['post_id'],
      platform_id: entry['platform_id']
    }
  end

  def self.mount_data_from entry
    data = {}
    data[:news] = [
      {
        title: entry['post_title'],
        content: entry['post_content'],
        author: entry['post_author'],
        image: entry['post_image_full'],
        timestamp: DateTime.now.to_s
      }
    ]
    data
  end

  def self.mount_resource entry
    {
      worker: News[:catracalivre_gatherer_worker],
      worker_uuid: entry['post_id'],
      lat: entry['place_geolocation'][0].split(',')[0],
      lon: entry['place_geolocation'][0].split(',')[1],
      post_id: entry['post_id'],
      platform_id: entry['platform_id']
      status: 'active'
    }
  end

  def self.collection
    :news
  end
end

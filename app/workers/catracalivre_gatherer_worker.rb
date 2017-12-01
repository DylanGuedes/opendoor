class CatracalivreGathererWorker
  include Sidekiq::Worker

  @@cron_scheduled = false

  def self.cron_running
    @@cron_scheduled
  end

  def self.turn_on
    @@cron_scheduled = true
  end

  BASE_URL = "https://api.catracalivre.com.br"
  CITY_ID = 9668
  DAYS_TO_MONITORING = 5

  def perform(platform_id)
    platform = Platform.find(platform_id)
    url = BASE_URL + "/select/?q=places_cidades.id:#{CITY_ID} AND"\
            " post_publish_date:[NOW-#{DAYS_TO_MONITORING}DAYS TO NOW]&wt=json"
    response = JSON.parse(RestClient.get(url))
    docs = response['response']['docs']
    docs.each do |post|
      attrs = {
        platform_id: platform_id,
        worker_uuid: post['post_id']
      }

      puts "Loading resource #{attrs} ..."
      resource = News.where(attrs)

      case
      when resource.count == 1
        resource = resource.first

        new_data = {}
        new_data[:news] = [
          {
            title: post['post_title'],
            author: post['post_author'],
            content: post['post_content'],
            image: post['post_image_full'],
            url: post['post_site_referrer']['siteurl']
          }
        ]

        update_resource_data(resource, {data: new_data})
      when resource.count > 1
        raise "Multiple resources for worker_uuid #{post['post_id']}"
      when
        create_resource(post, platform_id)
      end
    end
  end

  def update_resource_data(resource, new_data)
    resource.send_data(new_data)
  end

  def create_resource(post, platform_id)
    resource_data = {
      worker: News.workers[:catracalivre_gatherer_worker],
      worker_uuid: post['post_id'],
      lat: post['place_geolocation'][0].split(',')[0],
      lon: post['place_geolocation'][0].split(',')[1],
      status: 'active',
      platform_id: platform_id,
      post_id: post['post_id']
    }
    res = News.new(resource_data)
    if res.save
      res.fetch_or_register
    else
      raise "News not saved: #{post['post_id']}"
    end
  end
end

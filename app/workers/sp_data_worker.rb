class SpDataWorker
  include Sidekiq::Worker

  # This class gather data from a MongoDB dump and inject it in an InterSCity
  # instance. It will manage the uuids and being sure to not replicate resources
  # based on the `fetch` method that must be overwritten.

  @@cron_scheduled = false

  def self.cron_running
    @@cron_scheduled
  end

  def self.turn_on
    @@cron_scheduled = true
  end

  # Fetch data from a MongoDB dump and inject in the given platform instance.
  # The klass attribute is the class of a given resource; i.e: AirQuality.
  # Example: SpDataWorker.perform_async('Ibirapuera', 1,
  # 'mongodb://127.0.0.1:27017', 'sp', AirQuality)
  def perform(platform_id, db_host, db_name, klass,limit=nil)
    db = Mongo::Client.new(db_host, :database => db_name)
    klass = klass.constantize # BUG: Sidekiq turns class into a string
    collection = db[klass.collection]
    idx = 0
    collection.find.each do |entry|
      idx += 1
      if idx == limit
        break
      end
      entry[:platform_id] = platform_id
      attrs = klass.fetch(entry)
      resource = klass.find_by(attrs)

      if resource and resource.uuid
        new_data = klass.mount_data_from(entry)
        resource.send_data({data: new_data})
      else
        data = klass.mount_resource(entry)
        resource = klass.create(data)
        resource.fetch_or_register
      end
    end
  end
end

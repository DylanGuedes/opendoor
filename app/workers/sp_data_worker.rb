class CetesbGathererWorker
  include Sidekiq::Worker

  ###
  # This class gather data from a MongoDB dump and inject it in an InterSCity
  # instance.

  @@cron_scheduled = false

  def self.cron_running
    @@cron_scheduled
  end

  def self.turn_on
    @@cron_scheduled = true
  end

  # Fetch data from a MongoDB dump and inject in the given platform instance.
  # The klass attribute is the class of a given resource; i.e: AirQuality.
  def perform(region, platform_id, db_host, db_name, klass)
    db = Mongo::Client.new(db_host, :database => db_name)
    collection = db[klass.collection]
    collection.find.each do |entry|
      entry[:platform_id] = platform_id
      attrs = klass.fetch(entry)
      resource = klass.find_by(attrs)

      if resource and resource.uuid
        new_data = klass.mount_data_from(entry)
        resource.send_data(new_data)
      else
        data = klass.mount_resource(entry)
        resource = klass.create(data)
        resource.fetch_or_register
      end
    end
  end

  def update_resource_data(resource, new_data)
    resource.send_data(new_data)
  end
end

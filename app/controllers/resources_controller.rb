class ResourcesController < ApplicationController
  RESOURCE_TYPES = [AirQuality]

  def index
    @resources = []
    RESOURCE_TYPES.each do |x|
      @resources += x.all
    end
  end

  def fetch_cetesb_data
    if cookies[:instance_id]
      CetesbGathererWorker.perform_async(AirQuality.workers[:cetesb_gatherer_worker], cookies[:instance_id])
    end
    redirect_to resources_path
  end

  def active_cetesb_cron
    if cookies[:instance_id] and not CetesbGathererWorker.cron_running
      Sidekiq::Cron::Job.create(name: 'Cetesb every-5min',
                                cron: '*/5 * * * *',
                                class: 'CetesbGathererWorker',
                                args: [AirQuality.workers[:cetesb_gatherer_worker], cookies[:instance_id]])
      CetesbGathererWorker.turn_on
    end
    redirect_to resources_path
  end

  def dump_recovery
    @platforms = Platform.all.map{|p| [p.url, p.id]}
    @desired_resource = [ ["Air Quality", "AirQuality"] ]
  end

  def dump_and_inject
    SpDataWorker.perform_async(
      params[:platform_id],
      'mongodb://'+params[:db_host],
      params[:db_name],
      params[:resource_type],
      2 # limit
    )

    redirect_to resources_path
  end
end

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
      CetesbGathererWorker.perform_async(cookies[:instance_id])
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
      params[:resource_type]
    )

    redirect_to resources_path
  end

  def register_initiative
    if params[:instance_id]
      InitiativeRegistrationWorker.perform_async(initiative_params, params[:instance_id])
    end
    redirect_to resources_path
  end

  private

  def initiative_params
    params.require(:initiative).permit(:name, :state, :responsible_phone,
                                       :responsible, :responsible_email, :city,
                                       :address, :institution, :lat, :lon)
  end
end

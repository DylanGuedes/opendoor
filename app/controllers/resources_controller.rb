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
end

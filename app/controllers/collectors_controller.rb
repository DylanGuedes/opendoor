class CollectorsController < ApplicationController
  def collect
    platform_id = cookies[:instance_id]
    if not platform_id
      if Platform.count
        platform_id = Platform.all[0]
      else
        platform_id = Platform.create(url: 'localhost:3000').id
      end
    end
    collector_id = params[:collector_id]
    CetesbGathererWorker(collector_id, platform_id)
  end
end

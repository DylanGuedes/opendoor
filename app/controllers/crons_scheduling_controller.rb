class CronsSchedulingController < ApplicationController
  def cetesb_cron_index
    @platforms = Platform.all.map{|p| [p.url, p.id]}
  end

  def accuweather_cron_index
    @platforms = Platform.all.map{|p| [p.url, p.id]}
  end

  def citybik_cron_index
    @platforms = Platform.all.map{|p| [p.url, p.id]}
  end

  def catracalivre_cron_index
    @platforms = Platform.all.map{|p| [p.url, p.id]}
  end

  def cetesb_cron_activate
    interval = 5
    if params[:interval]
      interval = params[:interval].to_i
    end

    if cookies[:instance_id]
      Sidekiq::Cron::Job.create(name: 'Cetesb cron',
                                cron: "*/#{interval} * * * *",
                                class: 'CetesbGathererWorker',
                                args: [params[:platform_id]])
      CetesbGathererWorker.turn_on
    end
    redirect_to resources_path
  end

  def citybik_cron_activate
    interval = 5
    if params[:interval]
      interval = params[:interval].to_i
    end

    if cookies[:instance_id]
      Sidekiq::Cron::Job.create(name: 'Citybik cron',
                                cron: "*/#{interval} * * * *",
                                class: 'CitybikGathererWorker',
                                args: [params[:platform_id]])
      CitybikGathererWorker.turn_on
    end
    redirect_to resources_path
  end

  def accuweather_cron_activate
    interval = 5
    if params[:interval]
      interval = params[:interval].to_i
    end

    if params[:platform_id]
      Sidekiq::Cron::Job.create(name: 'Accuweather cron',
                                cron: "*/#{interval} * * * *",
                                class: 'AccuweatherGathererWorker',
                                args: [params[:platform_id]])
      AccuweatherGathererWorker.turn_on
    end
    redirect_to resources_path
  end

  def catracalivre_cron_active
    interval = 5
    if params[:interval]
      interval = params[:interval].to_i
    end

    if params[:platform_id]
      Sidekiq::Cron::Job.create(name: 'Catraca livre cron',
                                cron: "*/#{interval} * * * *",
                                class: 'CatracalivreGathererWorker',
                                args: [params[:platform_id]])
      CatracalivreGathererWorker.turn_on
    end
    redirect_to resources_path
  end
end

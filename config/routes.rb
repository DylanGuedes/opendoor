require 'sidekiq/web'
require 'sidekiq/cron/web'

Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  #
  root 'application#index'
  get '/home', to: 'application#index'
  mount Sidekiq::Web => '/sidekiq'
  resources 'platforms'
  post '/initiatives/register', to: 'resources#register_initiative'
  get '/set_platform/:platform_id', to: 'platforms#set_instance'
  get '/resources', to: 'resources#index'
  get '/resources/cetesb_gatherer', to: 'resources#fetch_cetesb_data'
  get '/resources/accuweather_gatherer', to: 'resources#fetch_accuweather_data'
  get '/resources/citybik_gatherer', to: 'resources#fetch_citybik_data'
  get '/resources/catracalivre_gatherer', to: 'resources#fetch_catracalivre_data'
  get '/resources/active_cetesb_cron', to: 'resources#active_cetesb_cron'
  get '/dump_recovery', to: 'resources#dump_recovery'
  get '/cetesb_cron_index', to: 'crons_scheduling#cetesb_cron_index'
  get '/accuweather_cron_index', to: 'crons_scheduling#accuweather_cron_index'
  get '/citybik_cron_index', to: 'crons_scheduling#citybik_cron_index'
  get '/catracalivre_cron_index', to: 'crons_scheduling#catracalivre_cron_index'
  post '/cetesb_cron_activate', to: 'crons_scheduling#cetesb_cron_activate'
  post '/accuweather_cron_activate', to: 'crons_scheduling#accuweather_cron_activate'
  post '/citybik_cron_activate', to: 'crons_scheduling#citybik_cron_activate'
  post '/catracalivre_cron_activate', to: 'crons_scheduling#catracalivre_cron_activate'
  post '/dump_and_inject', to: 'resources#dump_and_inject'
end

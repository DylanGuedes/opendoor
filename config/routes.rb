Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root 'application#index'
  get '/home', to: 'application#index'
  resources 'platforms'
  post '/initiatives/register', to: 'resources#register_initiative'
  get '/set_platform/:platform_id', to: 'platforms#set_instance'
  get '/resources', to: 'resources#index'
  get '/resources/cetesb_gatherer', to: 'resources#fetch_cetesb_data'
  get '/resources/active_cetesb_cron', to: 'resources#active_cetesb_cron'
  get '/dump_recovery', to: 'resources#dump_recovery'
  post '/dump_and_inject', to: 'resources#dump_and_inject'
end

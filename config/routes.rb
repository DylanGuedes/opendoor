Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  get '/home', to: 'application#index'
  resources 'platforms'
  get '/set_platform/:platform_id', to: 'platforms#set_instance'
end

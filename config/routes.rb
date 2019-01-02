Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  get '/fromsource/:source/:type', to: 'exchange_rate#fromsource'
  get '/showrate/:date/:fromccy/:toccy', to: 'exchange_rate#showrate'
  
end

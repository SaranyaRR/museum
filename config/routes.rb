Museum::Application.routes.draw do

  resources :tickets, only: [:index] do
    collection { post :import }
    collection { post :search }
    collection { get :list }
  end
  #get 'tickets/list' => 'tickets#list'

  #resources :tickets, only: [:index] do
  #  get '/search',  to: 'tickets#search'
  #  get '/list',    to: 'tickets#list'
  #  post '/import', to: 'tickets#import'
  #end

  root to: "tickets#index"
end

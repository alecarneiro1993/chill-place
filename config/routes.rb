Rails.application.routes.draw do
  devise_for :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  root to: 'pages#index'

  scope controller: :pages do
    get '/library' => :library, as: :library
    get '/store' => :store, as: :store
    get '/store_json' => :store_json
    get '/checkout/:id' => :checkout, as: :checkout
  end

  scope controller: :purchases do
    post '/purchases' => :create, as: :purchases
  end

  namespace :api do
    scope controller: :fetch do
      get '/all' => :index
      get '/movies' => :movies
      get '/seasons' => :seasons
    end
    scope controller: :purchases do
      get '/purchases' => :index
      post '/purchases' => :create
    end

  end

end

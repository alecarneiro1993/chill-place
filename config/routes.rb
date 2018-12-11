Rails.application.routes.draw do
  devise_for :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  root to: 'pages#index'

  scope controller: :pages do
    get '/library' => :library, as: :library
    get '/store' => :store, as: :store
  end

end

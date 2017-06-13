Rails.application.routes.draw do
  root to: 'visitors#index'
  get 'products/:id', to: 'products#show', :as => :products

  devise_for :users,
             :controllers  => { :registrations => 'my_devise/registrations' }
  resources :users
end

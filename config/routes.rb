Rails.application.routes.draw do
  resources :products
  resources :users
  get 'signup', to: 'users#new'
  post 'signup', to: 'users#create'
  controller :session do
    get 'login' => :new
    post 'login' => :create
    delete 'logout' => :destroy
  end
  get 'admin', to: 'admin#index'
  resources :support_requests, only: %i[index update]
  scope '(:locale)' do
    get "store/index"
    root "store#index"
    resources :carts
    resources :orders
    resources :line_items do
      member do 
        patch :update_quantity
      end
    end
  end
    # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
    
  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  # get "up" => "rails/health#show", as: :rails_health_check

  # Defines the root path route ("/")
end

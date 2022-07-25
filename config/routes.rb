Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  resources :pets do
    resources :registrations, only: :create
  end
  post 'auth/login', to: 'authentication#authenticate'
  post 'signup', to: 'users#create'
  
end

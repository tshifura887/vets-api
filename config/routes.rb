Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  resources :pets do
    resources :registrations do
      resources :appointments, only: [:create]
    end
  end
  get 'registrations/:pet_id', to: 'registrations#pets_registrations'

  post 'auth/login', to: 'authentication#authenticate'
  post 'signup', to: 'users#create'

  get '/users/:id', to: 'users#show'
  delete '/users/:id', to: 'users#destroy'


end

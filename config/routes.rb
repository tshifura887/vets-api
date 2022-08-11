Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  resources :pets do
    resources :registrations do
      resources :appointments, only: [:create, :index]
    end
  end
  get 'registrations/:pet_id', to: 'registrations#pets_registrations'
  get 'appointments/:registration_id', to: 'appointments#registrations_appointments'

  post 'auth/login', to: 'authentication#authenticate'
  delete 'auth/logout', to: 'authentication#destroy'
  post 'signup', to: 'users#create'

  get '/user', to: 'users#show'
  delete '/users/:id', to: 'users#destroy'
end

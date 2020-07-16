Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  post 'login', to: 'authentication#authenticate'
  post 'signup', to: 'users#create'
  resources :users, only: %i(show update index)
  resources :events
  get 'events/:id/url', to: 'events#generate_invitation_url'
  get 'events/:id/invitation', to: 'events#event_invitation'
end

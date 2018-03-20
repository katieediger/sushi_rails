Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  resources :sushi do
    collection do
      get ':id/test', to: 'sushi#test'
      get ':id/call', to: 'sushi#call'
    end
  end
  resources :organization
  resources :datum 
  resources :user
  resources :about
  root to: 'about#index'
  get '/contact', to: 'about#contact'
  get '/validsushi', to: 'validsushi#index'
  get '/import', to: 'validsushi#import'
  get '/auth/:provider/callback', to: 'sessions#create'
  delete '/logout', to: 'sessions#destroy'
  get '/auth/failure', to: 'sessions#destroy'
  post '/', to: 'error#not_found'
  get '*path', to: 'error#not_found'
end

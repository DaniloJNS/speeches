# frozen_string_literal: true

Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  namespace :api, defaults: { format: :json } do
    namespace :v1 do
      resources :speeches, only: %i[index create show]
      post 'authenticate', to: 'authentication#create'
    end
  end
end

require 'pushar/api_constraints'

Pushar::Engine.routes.draw do

  resources :apps
  resources :devices

  namespace :api do
    scope module: :v1, constraints: ApiConstraints.new(version: 1, default: :true), :format => :json do
      resources :devices, :only => [:create]
    end
  end

  root to: "apps#index"
end

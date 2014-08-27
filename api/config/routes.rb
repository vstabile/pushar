require 'api_constraints'

module Pushar
  Api::Engine.routes.draw do
    scope module: :v1, constraints: ApiConstraints.new(version: 1, default: true), :format => :json do
      resources :subscriptions, :only => [:create, :destroy] do
        get "unsubscribe", :on => :collection
      end
      resources :devices
      post "feedback" => "subscriptions#feedback"
    end
  end
end

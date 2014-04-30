require 'api_constraints'

module Pushar
  Api::Engine.routes.draw do
    scope module: :v1, constraints: ApiConstraints.new(version: 1, default: true), :format => :json do
      resources :subscriptions, :only => [:create, :destroy]
    end
  end
end

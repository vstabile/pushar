module Pushar
  Admin::Engine.routes.draw do
    resources :apps
    resources :devices
    resources :subscriptions

    root to: "apps#index"
  end
end
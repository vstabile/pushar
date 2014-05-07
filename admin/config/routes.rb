module Pushar
  Admin::Engine.routes.draw do
    resources :apps
    resources :devices
    resources :subscriptions
    resources :newsletters

    root to: "subscriptions#index"
  end
end
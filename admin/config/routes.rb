module Pushar
  Admin::Engine.routes.draw do
    resources :apps
    resources :devices
    resources :subscriptions do
      get "resubscribe", :on => :member
    end
    resources :newsletters

    root to: "subscriptions#index"
  end
end
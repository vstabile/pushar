module Pushar
  Admin::Engine.routes.draw do
    resources :apps
    resources :devices

    root to: "apps#index"
  end
end
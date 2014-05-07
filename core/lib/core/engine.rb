require 'email_tracker/rack'

module Pushar
  module Core
    class Engine < ::Rails::Engine
      isolate_namespace Pushar::Core

      require_dependency 'email_tracker/rack'

      initializer 'core.action_controller' do |app|
        ActiveSupport.on_load :action_controller do
          helper Pushar::Core::NewslettersHelper
        end
      end

      initializer 'core.add_middleware' do |app|
        app.middleware.use Pushar::Core::EmailTracker::Rack
      end
    end
  end
end

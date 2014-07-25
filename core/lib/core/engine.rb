require 'email_tracker/rack'

module Pushar
  module Core
    class Engine < ::Rails::Engine
      isolate_namespace Pushar::Core

      initializer 'core.action_controller' do |app|
        ActiveSupport.on_load :action_controller do
          helper Pushar::Core::NewslettersHelper
        end
      end

      initializer 'core.add_middleware' do |app|
        app.middleware.use Pushar::Core::EmailTracker::Rack
      end
    end

    def self.config(&block)
      yield Engine.config if block
      Engine.config
    end
  end
end

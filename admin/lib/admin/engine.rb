require "jquery-rails"
require "sass"
require "bootstrap-rails"

module Pushar
  module Admin
    class Engine < ::Rails::Engine
      isolate_namespace Pushar::Admin
    end
  end
end

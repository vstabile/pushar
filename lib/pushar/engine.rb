require "jquery-rails"
require "sass"
require "bootstrap-rails"

module Pushar
  class Engine < ::Rails::Engine
    isolate_namespace Pushar
  end
end

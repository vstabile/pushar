module Pushar
  module Api
    class Engine < ::Rails::Engine
      isolate_namespace Pushar::Api
    end
  end
end

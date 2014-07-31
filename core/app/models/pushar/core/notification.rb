module Pushar
  module Core
    class Notification < ActiveRecord::Base
      belongs_to :app, counter_cache: true
      
    end
  end
end

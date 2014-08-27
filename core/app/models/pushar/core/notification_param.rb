module Pushar
  module Core
    class NotificationParam < ActiveRecord::Base
      belongs_to :notification
      
    end
  end
end

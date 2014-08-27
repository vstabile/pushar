module Pushar
  module Core
    class NotificationOption < ActiveRecord::Base
      belongs_to :notification
      
    end
  end
end

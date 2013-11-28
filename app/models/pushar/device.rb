module Pushar
  class Device < ActiveRecord::Base
    belongs_to :app, counter_cache: true

    validates :token, :app_id, presence: true

    after_update :update_inactive_count if :inactivated_at_changed?

    def update_inactive_count
      if !inactivated_at.nil?
        app.increment!(:inactive_devices_count)
      else
        app.decrement!(:inactive_devices_count)
      end  
    end

  end
end

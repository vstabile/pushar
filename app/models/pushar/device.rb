module Pushar
  class Device < ActiveRecord::Base
    belongs_to :app, counter_cache: true

    validates :token, :app_id, presence: true
  end
end

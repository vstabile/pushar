module Pushar
  module Core
    class Newsletter < ActiveRecord::Base
      validates :name, presence: true
    end
  end
end
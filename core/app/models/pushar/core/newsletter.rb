module Pushar
  module Core
    class Newsletter < ActiveRecord::Base
      validates :name, presence: true

      def self.find_or_create_by_name(name)
        self.find_by_name(name) || self.create(:name => name)
      end
    end
  end
end
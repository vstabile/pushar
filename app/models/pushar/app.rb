module Pushar
  class App < ActiveRecord::Base
    has_many :devices

    validates :name, :platform, presence: true
    validates :platform, inclusion: { in: %w(android ios amazon), message: "%{value} is not a valid platform" }

    def name_with_platform
      "#{name} (#{platform})"
    end
  end
end

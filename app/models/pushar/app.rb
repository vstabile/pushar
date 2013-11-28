module Pushar
  class App < ActiveRecord::Base
    has_many :devices

    validates :name, :platform, presence: true
    validates :platform, inclusion: { in: %w(android ios amazon), message: "%{value} is not a valid platform" }
    validates :gcm_api_key, presence: true, :if => :android?
    validates :apn_app_key, :apn_dev_cert, presence: true, :if => :ios?
    validates :adm_client_id, :adm_client_secret, presence: true, :if => :amazon?

    def name_with_platform
      "#{name} (#{platform})"
    end

    def android?
      platform == "android"
    end

    def ios?
      platform == "ios"
    end

    def amazon?
      platform == "amazon"
    end
  end
end

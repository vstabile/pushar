module Pushar
  module Core
    class Notification < ActiveRecord::Base
      belongs_to :app, counter_cache: true
      has_many :notification_params
      has_many :notification_options
      accepts_nested_attributes_for :notification_params
      accepts_nested_attributes_for :notification_options
      
      def message
        message = {}
        notification_params.each do |param|
          message[param.key.to_sym] = param.value 
        end
        message
      end

      def options
        options = {}
        notification_options.each do |option|
          options[option.key.to_sym] = option.value 
        end
        options
      end

      def create_message(params)
        params.each do |k, v|
          notification_params.build(:key => k, :value => v)
        end
        save
      end

      def create_options(params)
        params.each do |k, v|
          notification_options.build(:key => k, :value => v)
        end
        save
      end

      def publish!
        case
          # iOS
          when app.ios?
            APNS.host = Rails.env != "production" ? 'gateway.push.apple.com' : 'gateway.sandbox.push.apple.com'
            APNS.port = 2195
            APNS.pem = Rails.env != "production" ? app.apn_prod_cert : app.apn_dev_cert
            APNS.pass = app.apn_app_key
            APNS.start_persistence
            notifications = []
            app.devices.find_each do |device|
             notifications.push(APNS::Notification.new(device.token, :alert => message[:alert], :badge => message[:badge], :sound => message[:sound], :other => options))
            end
            puts APNS.send_notifications(notifications)
            APNS.stop_persistence
          # Android
          when app.android?
            GCM.host = 'https://android.googleapis.com/gcm/send'
            GCM.format = :json
            GCM.key = app.gcm_api_key
            notifications = []
            app.devices.find_each do |device|
              notifications.push(GCM::Notification.new(device.token, message, :options => options))
            end
            # {:title => "DICKBUTT", :image => "http://i.imgur.com/3R2McZq.jpg", :post_id => 1}
            puts GCM.send_notifications(notifications)
          # Kindle
          when app.amazon?
            FIRE.client_id = app.adm_client_id
            FIRE.client_secret = app.adm_client_secret
            notifications = []
            app.devices.find_each do |device|
              notifications.push(FIRE::Notification.new(device.token, :data => message, :options => options))
            end
            puts FIRE.send_notifications(notifications)
        end
      end
    end
  end
end

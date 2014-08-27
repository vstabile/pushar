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
    end
  end
end

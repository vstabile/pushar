# require_dependency "api/application_controller"

module Pushar
  module Api
    module V1
      class DevicesController < Pushar::Api::V1::ApplicationController
        skip_before_filter :verify_authenticity_token
        before_action :set_device, only: [:create]
        respond_to :json

        def create
          @device = ::Pushar::Core::Device.new if @device.nil?
          @device.user_id = current_user.id if current_user
          @device.updated_at = Time.now unless @device.new_record?
          @device.update_attributes(device_params)
          respond_with @device
        end

        private
          def set_device
            @device = ::Pushar::Core::Device.find_by_token(device_params[:token])
          end

          def device_params
            params.require(:device).permit(:user_id, :token, :app_id, :locale, :inactivated_at, :banner, :badge, :sound, :app_name, :app_version, :os_name, :os_version, :device_name, :device_version)
          end
      end
    end
  end
end

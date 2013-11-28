require_dependency "pushar/application_controller"

module Pushar
  module Api
    module V1
      class DevicesController < Api::BaseController
        respond_to :json

        def create
          @device = Device.find_by_token(device_params[:token]) || Device.new
          device_params.delete :user_id if device_params[:user_id]
          @device.update_attributes(device_params)
          @device.updated_at = Time.now unless @device.new_record?
          respond_with @device
        end

        private
          def device_params
            params.require(:device).permit(:user_id, :token, :app_id, :locale, :banner, :badge, :sound, :app_name, :app_version, :os_name, :os_version, :device_name, :device_version, :inactivated_at)
          end
      end
    end
  end
end
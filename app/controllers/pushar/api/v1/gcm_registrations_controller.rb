require_dependency "pushar/application_controller"

module Pushar
  module Api
    module V1
      class GcmRegistrationsController < Api::BaseController
        skip_before_filter :authenticate_user!
        skip_before_filter :skip_trackable, :only => [:update, :show]
        respond_to :json

        def create
          current_user = User.find_by_authentication_token(params[:auth_token])
          @gcm_registration = GcmRegistration.find_by_registration_id(params[:gcm_registration][:registration_id]) || GcmRegistration.new
          @gcm_registration.user_id = current_user.id if current_user
          @gcm_registration.updated_at = Time.now unless @gcm_registration.new_record?
          @gcm_registration.update_attributes(params[:gcm_registration])
          respond_with @gcm_registration
        end
      end
    end
  end
end
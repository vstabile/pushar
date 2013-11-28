require_dependency "pushar/application_controller"

module Pushar
  module Api
    module V1
      class ApnRegistrationsController < Api::BaseController
        skip_before_filter :authenticate_user!
        skip_before_filter :skip_trackable, :only => [:update, :show]
        respond_to :json

        def create
          current_user = params[:auth_token].blank? ? nil : User.find_by_authentication_token(params[:auth_token])
          @apn_registration = ApnRegistration.find_by_token(params[:apn_registration][:token]) || ApnRegistration.new
          @apn_registration.user_id = current_user.id if current_user
          @apn_registration.updated_at = Time.now unless @apn_registration.new_record?
          @apn_registration.update_attributes(params[:apn_registration])
          respond_with @apn_registration
        end
      end
    end
  end
end
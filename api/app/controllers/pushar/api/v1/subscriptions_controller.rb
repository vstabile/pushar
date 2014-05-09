# require_dependency "api/application_controller"

module Pushar
  module Api
    module V1
      class SubscriptionsController < Pushar::Api::V1::ApplicationController
        skip_before_filter :verify_authenticity_token
        before_action :set_subscription, only: [:create, :destroy]
        respond_to :json

        def create
          if @subscription
            @subscription.unsubscribed_at = nil
          else
            @subscription = ::Pushar::Core::Subscription.new(subscription_params)
          end
          if @subscription.save
            render :nothing => true, :status => :ok
          else
            render :nothing => true, :status => :unprocessable_entity
          end
        end

        def destroy
          if @subscription && @subscription.destroy
            render :nothing => true, :status => :ok
          else
            render :nothing => true, :status => :unprocessable_entity
          end
        end

        private
          def set_subscription
            @subscription = ::Pushar::Core::Subscription.unscoped.find_by_id(params[:id]) || 
                              ::Pushar::Core::Subscription.unscoped.find_by_email(subscription_params[:email])
          end

          def subscription_params
            params.require(:subscription).permit(:email, :send_count, :open_count, :last_opened_at, :unsubscribed_at)
          end
      end
    end
  end
end

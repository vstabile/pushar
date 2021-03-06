# require_dependency "api/application_controller"
require "open-uri"

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

        # PUT /feedback
        def feedback
          response = JSON.parse(request.body.read)
          if response["Type"] == "SubscriptionConfirmation"
            data = URI.parse(response["SubscribeURL"]).read
            render :nothing => true, :status => :ok
          elsif response["Type"] == "Notification"
            message = JSON.parse(response["Message"])
            if message["notificationType"] == "Bounce"
              recipients = message["bounce"]["bouncedRecipients"]
              subscription_emails = recipients.collect {|recipient| recipient["emailAddress"]}
              subscription_emails.each do |email|
                subscription = Pushar::Core::Subscription.where(:tenant_id => params[:tenant_id]).find_by_email(email)
                subscription.update_attributes(:unsubscribed_at => Time.now, :unsubscribe_reason => "Bounce")
              end
            elsif message["notificationType"] == "Complaint"
              recipients = message["complaint"]["complainedRecipients"]
              subscription_emails = recipients.collect {|recipient| recipient["emailAddress"]}
              subscription_emails.each do |email|
                subscription = Pushar::Core::Subscription.where(:tenant_id => params[:tenant_id]).find_by_email(email)
                subscription.update_attributes(:unsubscribed_at => Time.now, :unsubscribe_reason => "Complaint")
              end
            end
            render :nothing => true, :status => :ok
          else
            render :nothing => true, :status => :unprocessable_entity
          end
        end

        def unsubscribe
          token = params[:token]
          redirect_path = params[:redirect_path] || '/'

          subscription = Pushar::Core::Subscription.from_token(token)
          if subscription
            subscription.update_attribute :unsubscribed_at, Time.now
            redirect_to redirect_path, :notice => "O email #{subscription.email} foi descadastrado."
          else
            redirect_to redirect_path, :notice => "Este link é inválido"
          end
        end

        private
          def set_subscription
            @subscription = ::Pushar::Core::Subscription.unscoped.find_by_id(params[:id]) || 
                              ::Pushar::Core::Subscription.unscoped.where(tenant_id: subscription_params[:tenant_id]).find_by_email(subscription_params[:email])
          end

          def subscription_params
            params.require(:subscription).permit(:email, :send_count, :open_count, :last_opened_at, :unsubscribed_at, :tenant_id)
          end
      end
    end
  end
end

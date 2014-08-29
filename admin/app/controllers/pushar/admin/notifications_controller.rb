# require_dependency "admin/application_controller"
require 'pushmeup'

module Pushar
  module Admin
    class NotificationsController < Pushar::Admin::ApplicationController
      before_action :set_notification, only: [:show, :edit, :update, :destroy, :publish]
      before_action :config_notification, only: [:publish]
      # before_action :set_tenant

      # GET /notifications
      def index
        @q = ::Pushar::Core::Notification.includes(:app).search(params[:q])
        @q.sorts = 'created_at desc' if @q.sorts.empty?
        @notifications = @q.result(distinct: true).page(params[:page]).per(50)
      end

      # GET /notifications/1
      def show
      end

      # GET /notifications/new
      def new
        @notification = ::Pushar::Core::Notification.new
      end

      # GET /notifications/1/edit
      def edit
      end

      # POST /notifications
      def create
        @notification = ::Pushar::Core::Notification.new(notification_params)

        if @notification.save
          redirect_to @notification, notice: 'Notification was successfully created.'
        else
          render action: 'new'
        end
      end

      # PATCH/PUT /notifications/1
      def update
        if @notification.update(notification_params)
          redirect_to @notification, notice: 'Notification was successfully updated.'
        else
          render action: 'edit'
        end
      end

      # DELETE /notifications/1
      def destroy
        @notification.destroy
        redirect_to notifications_url, notice: 'Notification was successfully destroyed.'
      end

      def publish
        case 
          # iOS
          when @notification.app.ios?
            APNS.start_persistence
            notifications = []
            @notification.app.devices.find_each do |device|
             notifications.push(APNS::Notification.new(device.token, :alert => @notification.message[:alert], :badge => @notification.message[:badge], :sound => @notification.message[:sound], :other => @notification.options))
            end
            puts APNS.send_notifications(notifications)
            APNS.stop_persistence
          # Android
          when @notification.app.android?
            notifications = []
            @notification.app.devices.find_each do |device|
              notifications.push(GCM::Notification.new(device.token, :data => @notification.message, :options => @notification.options))
            end
            puts GCM.send_notifications(notifications)
          # Kindle
          when @notification.app.amazon?
            notifications = []
            @notification.app.devices.find_each do |device|
              notifications.push(FIRE::Notification.new(device.token, :data => @notification.message, :options => @notification.options))
            end
            puts FIRE.send_notifications(notifications)
        end
        @notification.update_attribute(:sent_at, Time.now)
        redirect_to notifications_path, notice: 'Notification was successfully sent.'
      end

      private
        # Use callbacks to share common setup or constraints between actions.
        def set_notification
          @notification = ::Pushar::Core::Notification.includes(:app).find(params[:id])
        end

        # Only allow a trusted parameter "white list" through.
        def notification_params
          params.require(:notification).permit(:message, :options, :app_id, :sent_at, :notification_params_attributes => [:id, :key, :value, :_destroy], :notification_options_attributes => [:id, :key, :value, :_destroy])
        end

        def config_notification
          case
            # iOS
            when @notification.app.ios?
              APNS.host = Rails.env == "production" ? 'gateway.push.apple.com' : 'gateway.sandbox.push.apple.com'
              APNS.port = 2195
              APNS.pem = Rails.env == "production" ? @notification.app.apn_prod_cert : @notification.app.apn_dev_cert
              APNS.pass = "" # @notification.app.apn_app_key
            # Android
            when @notification.app.android?
              GCM.host = 'https://android.googleapis.com/gcm/send'
              GCM.format = :json
              GCM.key = @notification.app.gcm_api_key   
            # Kindle
            when @notification.app.amazon?
              FIRE.client_id = @notification.app.adm_client_id
              FIRE.client_secret = @notification.app.adm_client_secret
          end
        end
    end
  end
end

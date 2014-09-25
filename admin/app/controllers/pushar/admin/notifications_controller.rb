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
        @notification.publish!
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
    end
  end
end

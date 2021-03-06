# require_dependency "admin/application_controller"

module Pushar
  module Admin
    class DevicesController < Pushar::Admin::ApplicationController
      before_action :set_device, only: [:show, :edit, :update, :destroy]

      # GET /devices
      def index
        @q = ::Pushar::Core::Device.unscoped.includes(:app).search(params[:q])
        @q.sorts = 'created_at desc' if @q.sorts.empty?
        @devices = @q.result(distinct: true).page(params[:page]).per(50)
      end

      # GET /devices/1
      def show
      end

      # GET /devices/new
      def new
        @device = ::Pushar::Core::Device.new
      end

      # GET /devices/1/edit
      def edit
      end

      # POST /devices
      def create
        @device = ::Pushar::Core::Device.new(device_params)

        if @device.save
          redirect_to @device, notice: 'Device was successfully created.'
        else
          render action: 'new'
        end
      end

      # PATCH/PUT /devices/1
      def update
        if @device.update(device_params)
          redirect_to @device, notice: 'Device was successfully updated.'
        else
          render action: 'edit'
        end
      end

      # DELETE /devices/1
      def destroy
        @device.destroy
        redirect_to devices_url, notice: 'Device was successfully destroyed.'
      end

      private
        # Use callbacks to share common setup or constraints between actions.
        def set_device
          @device = ::Pushar::Core::Device.includes(:app).find(params[:id])
        end

        # Only allow a trusted parameter "white list" through.
        def device_params
          params.require(:device).permit(:user_id, :token, :app_id, :locale, :inactivated_at, :banner, :badge, :sound, :app_name, :app_version, :os_name, :os_version, :device_name, :device_version)
        end
    end
  end
end

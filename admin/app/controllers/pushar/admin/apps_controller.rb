# require_dependency "admin/application_controller"

module Pushar
  module Admin
    class AppsController < Pushar::Admin::ApplicationController
      before_action :set_app, only: [:show, :edit, :update, :destroy]

      # GET /apps
      def index
        @q = ::Pushar::Core::App.unscoped.search(params[:q])
        @q.sorts = 'created_at desc' if @q.sorts.empty?
        @apps = @q.result(distinct: true).page(params[:page]).per(50)
      end

      # GET /apps/1
      def show
      end

      # GET /apps/new
      def new
        @app = ::Pushar::Core::App.new
      end

      # GET /apps/1/edit
      def edit
      end

      # POST /apps
      def create
        @app = ::Pushar::Core::App.new(app_params)

        if @app.save
          redirect_to @app, notice: 'App was successfully created.'
        else
          render action: 'new'
        end
      end

      # PATCH/PUT /apps/1
      def update
        if @app.update(app_params)
          redirect_to @app, notice: 'App was successfully updated.'
        else
          render action: 'edit'
        end
      end

      # DELETE /apps/1
      def destroy
        @app.destroy
        redirect_to apps_url, notice: 'App was successfully destroyed.'
      end

      private
        # Use callbacks to share common setup or constraints between actions.
        def set_app
          @app = ::Pushar::Core::App.find(params[:id])
        end

        # Only allow a trusted parameter "white list" through.
        def app_params
          params.require(:app).permit(:name, :platform, :apn_dev_cert, :apn_prod_cert, :apn_app_key, :gcm_api_key, :adm_api_key, :adm_client_id, :adm_client_secret)
        end
    end
  end
end

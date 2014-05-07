# require_dependency "pushar/application_controller"

module Pushar
  module Admin
    class NewslettersController < Pushar::Admin::ApplicationController
      before_action :set_newsletter, only: [:show, :edit, :update, :destroy]

      # GET /newsletters
      def index
        @q = ::Pushar::Core::Newsletter.unscoped.search(params[:q])
        @q.sorts = 'created_at desc' if @q.sorts.empty?
        @newsletters = @q.result(distinct: true).page(params[:page]).per(50)
      end

      # GET /newsletters/1
      def show
      end

      # GET /newsletters/new
      def new
        @newsletter = ::Pushar::Core::Newsletter.new
      end

      # GET /newsletters/1/edit
      def edit
      end

      # POST /newsletters
      def create
        @newsletter = ::Pushar::Core::Newsletter.new(newsletter_params)

        if @newsletter.save
          redirect_to @newsletter, notice: 'Newsletter was successfully created.'
        else
          render :new
        end
      end

      # PATCH/PUT /newsletters/1
      def update
        if @newsletter.update(newsletter_params)
          redirect_to @newsletter, notice: 'Newsletter was successfully updated.'
        else
          render :edit
        end
      end

      # DELETE /newsletters/1
      def destroy
        @newsletter.destroy
        redirect_to newsletters_url, notice: 'Newsletter was successfully destroyed.'
      end

      private
        # Use callbacks to share common setup or constraints between actions.
        def set_newsletter
          @newsletter = ::Pushar::Core::Newsletter.find(params[:id])
        end

        # Only allow a trusted parameter "white list" through.
        def newsletter_params
          params.require(:newsletter).permit(:name, :open_count, :send_count, :sent_at)
        end
    end
  end
end

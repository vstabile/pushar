# require_dependency "pushar/application_controller"

module Pushar
  module Admin
    class SubscriptionsController < ::Pushar::Admin::ApplicationController
      before_action :set_subscription, only: [:show, :edit, :update, :destroy]

      # GET /subscriptions
      def index
        @q = ::Pushar::Core::Subscription.unscoped.search(params[:q])
        @q.sorts = 'created_at desc' if @q.sorts.empty?
        @subscriptions = @q.result(distinct: true).page(params[:page]).per(50)
      end

      # GET /subscriptions/1
      def show
      end

      # GET /subscriptions/new
      def new
        @subscription = ::Pushar::Core::Subscription.new
      end

      # GET /subscriptions/1/edit
      def edit
      end

      # POST /subscriptions
      def create
        @subscription = ::Pushar::Core::Subscription.new(subscription_params)

        if @subscription.save
          redirect_to @subscription, notice: 'Subscription was successfully created.'
        else
          render action: 'new'
        end
      end

      # PATCH/PUT /subscriptions/1
      def update
        if @subscription.update(subscription_params)
          redirect_to @subscription, notice: 'Subscription was successfully updated.'
        else
          render action: 'edit'
        end
      end

      # DELETE /subscriptions/1
      def destroy
        @subscription.update_attribute(:unsubscribed_at, Time.now)
        redirect_to subscriptions_url, notice: 'Subscription was successfully destroyed.'
      end

      private
        # Use callbacks to share common setup or constraints between actions.
        def set_subscription
          @subscription = ::Pushar::Core::Subscription.find(params[:id])
        end

        # Only allow a trusted parameter "white list" through.
        def subscription_params
          params.require(:subscription).permit(:email, :send_count, :open_count, :last_opened_at, :unsubscribed_at)
        end
    end
  end
end

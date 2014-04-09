require_dependency "pushar/application_controller"


module Pushar
  class NewslettersController < ApplicationController
    before_filter :set_newsletter, :only => [:show, :destroy, :edit, :update, :publish]

    def new
      @newsletter = Newsletter.new
    end

    def show
    end

    def edit
    end
    
    def create
      @newsletter = Newsletter.new(newsletter_params)
      
      if @newsletter.save
        redirect_to newsletters_path
      else 
        render action: 'new'
      end
    end

    def index
      @newsletters = Newsletter.order("id DESC").page(params[:page]).per(25)
    end

    def destroy
      @newsletter.destroy

      redirect_to newsletters_path
    end 

    def update
      if @newsletter.update(newsletter_params)
        redirect_to newsletters_path
      else
        render action: 'edit'
      end
    end

    def publish
      if (@newsletter.sent_at.nil?)
        send_count = 0
        Subscription.find_each do |subscription|
          NewsletterMailer.daily(subscription, @newsletter).deliver
          send_count += 1
        end 
        @newsletter.update_attributes({ :send_count => send_count, :sent_at => Time.now })
        redirect_to :back, :notice => t("flash.newsletter_sent", send_count: send_count)
      else
        redirect_to newsletters_path, :notice => t("flash.newsletter_already_sent", send_count: send_count)
      end
    end
    

    private

    def set_newsletter
      @newsletter = Newsletter.find(params[:id])
    end
    
    def newsletter_params
      params.require(:newsletter).permit(:name, :send_count, :open_count, :sent_at)
    end
  end
end
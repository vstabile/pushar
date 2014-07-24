module Pushar
  module Admin
    class ApplicationController < ActionController::Base
      before_filter :set_tenant_id

      private
        def set_tenant_id
            @tenant_id = params[:tenant_id]
        end
    end
  end
end

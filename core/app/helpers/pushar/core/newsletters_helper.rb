include ActionView::Helpers::OutputSafetyHelper

module Pushar
  module Core
    module NewslettersHelper
      def self.track(newsletter_id, email, host, tenant_id = nil)
        url = "#{host}/email/track/#{Base64.encode64("newsletter_id=#{newsletter_id}&email=#{email}&tenant_id=#{tenant_id}")}.png"
        raw("<img src=\"#{url}\" alt=\"\" width=\"1\" height=\"1\">")
      end

      def self.unsubscribe(token, text, host)
        raw("<a href=\"#{host}/api/pushar/subscriptions/unsubscribe?token=#{token}\">#{text}</a>")
      end
    end
  end
end

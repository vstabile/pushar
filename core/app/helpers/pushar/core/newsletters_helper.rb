include ActionView::Helpers::OutputSafetyHelper

module Pushar
  module Core
    module NewslettersHelper
      def self.track(newsletter_id, email, host)
        url = "#{host}/email/track/#{Base64.encode64("newsletter_id=#{newsletter_id}&email=#{email}")}.png"
        raw("<img src=\"#{url}\" alt="" width=\"1\" height=\"1\">")
      end
    end
  end
end

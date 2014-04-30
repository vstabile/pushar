module Pushar
  module Core
    module NewslettersHelper
      def track(newsletter_id, email)
        url = "#{root_path(:only_path => false)}email/track/#{Base64.encode64("newsletter_id=#{newsletter_id}&email=#{email}")}.png"
        raw("<img src=\"#{url}\" alt="" width=\"1\" height=\"1\">")
      end
    end
  end
end

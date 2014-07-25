module Pushar
  module Core
    class Subscription < ActiveRecord::Base
      validates :email, uniqueness: { :scope => :tenant_id }, email: true

      default_scope { where("unsubscribed_at IS NULL") }

      # Get a subscription from a token
      def self.from_token(token)
        verified = verifier.verify(token)
        email = verified[:email]
        tenant_id = verified[:tenant_id]
        self.where(:tenant_id => tenant_id).find_by_email email
      rescue ActiveSupport::MessageVerifier::InvalidSignature
        nil
      end

      def generate_token
        verifier.generate({email: self.email, tenant_id: self.tenant_id})
      end

      # Verifier based on our application secret
      def self.verifier
        ActiveSupport::MessageVerifier.new(Pushar::Core.config.secret_key)
      end
      def verifier
        ActiveSupport::MessageVerifier.new(Pushar::Core.config.secret_key)
      end
    end
  end
end

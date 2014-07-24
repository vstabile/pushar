module Pushar
  module Core
    class Subscription < ActiveRecord::Base
      validates :email, uniqueness: { :scope => :tenant_id }, email: true

      default_scope { where("unsubscribed_at IS NULL") }

      # Get a subscription from a token
      def self.from_token(token, secret_key_base)
        email = verifier(secret_key_base).verify(token)
        self.find_by_email email
      rescue ActiveSupport::MessageVerifier::InvalidSignature
        nil
      end

      def generate_token(secret_key_base)
        verifier(secret_key_base).generate(self.email)
      end

      # Verifier based on our application secret
      def self.verifier(secret_key_base)
        ActiveSupport::MessageVerifier.new(secret_key_base)
      end
      def verifier(secret_key_base)
        ActiveSupport::MessageVerifier.new(secret_key_base)
      end
    end
  end
end

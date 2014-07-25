module Pushar
  module Core
    module EmailTracker
      class Rack
        def initialize(app)
          @app = app
        end

        def call(env)
          req = ::Rack::Request.new(env)

          if req.path_info =~ /^\/email\/track\/(.+).png/
            details = Base64.decode64(Regexp.last_match[1])
            newsletter_id = nil
            email = nil
            tenant_id = nil

            details.split('&').each do |kv|
              (key, value) = kv.split('=')
              case(key)
                when('newsletter_id')
                  newsletter_id = value
                when('email')
                  email = value
                when('tenant_id')
                  tenant_id = value
              end
            end

            if newsletter_id && email
              subscription = Pushar::Core::Subscription.unscoped.where(:tenant_id => tenant_id).find_by_email(email)
              if !subscription.blank?
                subscription.open_count += 1
                subscription.last_opened_at = Time.now
                subscription.save(:validate => false)
              end
              newsletter = Pushar::Core::Newsletter.unscoped.where(:tenant_id => tenant_id).find_by_id(newsletter_id)
              if !newsletter.blank?
                newsletter.increment!(:open_count)
              end
            end

            [ 200, { 'Content-Type' => 'image/png' }, [ File.read(File.join(File.dirname(__FILE__), 'track.png')) ] ]
          else
            @app.call(env)
          end
        end
      end
    end
  end
end
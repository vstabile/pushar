require_dependency "pushar/application_controller"

module Pushar
  module Api
    class BaseController < ::Pushar::Api::ApplicationController
      skip_before_filter :verify_authenticity_token
      before_filter :authenticate_api

      UA_MATCHER = %r{
        ^([^/\s]+)        # Product
        /?([^\s]*)        # Version
        (\s\(([^\)]*)\))? # Comment
      }x.freeze

      private

        def authenticate_api
          # API basic authentication
          authenticate_or_request_with_http_basic do |key, secret|
            key && secret && secret == Pushar::Api::Engine.config.authentication[key]
          end
        end

        # token authentications are not tracked as signing in
        def skip_trackable
          request.env['devise.skip_trackable'] = true
        end

        def user_agent
          # TODO: refactor
          begin
            string = request.user_agent.to_s
            @user_agent = {}
            ua = string.match(UA_MATCHER)
            @user_agent[:app] = { :name => ua[1], :version => ua[2], :comments => ua[4] }
            string = string[ua[0].length..-1].strip
            ua = string.match(UA_MATCHER)
            @user_agent[:os] = { :name => ua[1], :version => ua[2], :comments => ua[4] }
            string = string[ua[0].length..-1].strip
            ua = string.match(UA_MATCHER)
            @user_agent[:device] = { :name => ua[1], :version => ua[2], :comments => ua[4] }
            @user_agent
          rescue
            @user_agent = nil
          end
        end

        protected

          def self.set_pagination_headers(name, options = {})
            after_filter(options) do |controller|
              results = instance_variable_get("@#{name}")
              headers["X-Pagination"] = {
                total: results.total_count,
                total_pages: results.total_pages,
                first_page: results.first_page?,
                last_page: results.last_page?
              }.to_json
            end
          end
    end
  end
end
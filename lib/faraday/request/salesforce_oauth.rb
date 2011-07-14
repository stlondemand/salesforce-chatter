require 'faraday'

module Faraday
  class Request::SalesforceOAuth < Faraday::Middleware
    dependency 'simple_oauth'
    
    def call(env)
      params = env[:body] || {}
      signature_params = params

      params.map{ |k,v| signature_params = {} if v.respond_to?(:content_type) }
      
      if SalesforceChatter.authenticated?
        env[:request_headers]['Authorization'] = "OAuth #{SalesforceChatter.oauth_token}"
      end
      
      @app.call(env)
    end

    def initialize(app, options)
      @app, @options = app, options
    end
  end
end

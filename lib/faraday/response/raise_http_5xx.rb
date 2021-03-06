require 'faraday'

# @private
module Faraday
  # @private
  class Response::RaiseHttp5xx < Response::Middleware
    def on_complete(env)
      case env[:status].to_i
      when 500
        raise SalesforceChatter::InternalServerError.new(error_message(env, "Something is technically wrong."), env[:response_headers])
      when 502
        raise SalesforceChatter::BadGateway.new(error_message(env, "Something is technically wrong."), env[:response_headers])
      when 503
        raise SalesforceChatter::ServiceUnavailable.new(error_message(env, "Something is technically wrong."), env[:response_headers])
      end
    end

    private

    def error_message(env, body=nil)
      "#{env[:method].to_s.upcase} #{env[:url].to_s}: #{[env[:status].to_s + ':', body].compact.join(' ')} Check https://trust.salesforce.com/trust/status/ for updates on the status of the Salesforce API services."
    end
  end
end

require 'salesforce-chatter/connection'
require 'salesforce-chatter/request'
require 'salesforce-chatter/authentication'

module SalesforceChatter
  class API

    # @private
    attr_accessor *Configuration::VALID_OPTIONS_KEYS

    # Creates a new API
    def initialize(options={})
      self.oauth_token = options.delete :oauth_token
      options = SalesforceChatter.options.merge(options)
      Configuration::VALID_OPTIONS_KEYS.each do |key|
        send("#{key}=", options[key])
      end
    end

    include Connection
    include Request
    include Authentication
  end
end

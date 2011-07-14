require 'yajl'
require 'hashie'
require 'simple_oauth'
require 'salesforce-chatter/configuration'
require 'salesforce-chatter/api'
require 'salesforce-chatter/client'

module SalesforceChatter
  extend Configuration

  # Alias for SalesforceChatter::Client.new
  #
  # @return [SalesforceChatter::Client]
  def self.new(options={})
    SalesforceChatter::Client.new(options)
  end

  # Delegate to SalesforceChatter::Client
  def self.method_missing(method, *args, &block)
    return super unless new.respond_to?(method)
    new.send(method, *args, &block)
  end

  def self.respond_to?(method, include_private = false)
    new.respond_to?(method, include_private) || super(method, include_private)
  end
end
  

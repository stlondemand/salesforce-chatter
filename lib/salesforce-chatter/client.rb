module SalesforceChatter

  class Client < API
    require 'salesforce-chatter/client/feed_items'
    alias :api_endpoint :endpoint
    include SalesforceChatter::Client::FeedItems
  end

end

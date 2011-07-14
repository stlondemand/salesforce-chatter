module SalesforceChatter
  class Client
    # Defines methods related to feed items
    module FeedItems
      def feed_items(*args)
        options = args.last.is_a?(Hash) ? args.pop : {}
        user = args.first
        response = get('/chatter/feeds/news/me/feed-items', options)
      end
      
      def feed_item_create(text, options={})
        options[:text] = text
        response = post("/chatter/feeds/news/me/feed-items", options)
      end
      
      def feed_item_destroy(id, options={})
        response = delete("/chatter/feed-items/#{id}", options)
      end
      
      def feed_item(id, options={})
        response = get("/chatter/feed-items/#{id}", options)
      end
    end
  end
end

require File.expand_path(File.dirname(__FILE__) + '/spec_helper')

describe "SalesforceChatter" do

  after do
    SalesforceChatter.reset
  end

  describe ".configure" do

    SalesforceChatter::Configuration::VALID_OPTIONS_KEYS.each do |key|
      it "should set the #{key}" do
        SalesforceChatter.configure do |config|
          config.send("#{key}=", key)
          SalesforceChatter.send(key).should == key
        end
      end
    end

    it "should get an oauth token for the user" do
      SalesforceChatter.configure do |config|
        config.consumer_key    = ""
        config.consumer_secret = ""
        config.username        = ""
        config.password        = ""
        config.endpoint        = ""
        config.security_token  = ""
      end
      SalesforceChatter.authenticate
      SalesforceChatter.oauth_token.should_not be_nil
    end
    
    it "should reset auth token" do
      SalesforceChatter.configure do |config|
        config.consumer_key    = ""
        config.consumer_secret = ""
        config.username        = ""
        config.password        = ""
        config.endpoint        = ""
        config.security_token  = ""
      end
      SalesforceChatter.authenticate
      SalesforceChatter.reset
      SalesforceChatter.oauth_token.should == nil
    end
    
    it "should be able to use an existing auth token" do
      SalesforceChatter.configure do |config|
        config.consumer_key    = ""
        config.consumer_secret = ""
        config.username        = ""
        config.password        = ""
        config.endpoint        = ""
        config.security_token  = ""
      end
      SalesforceChatter.authenticate
      oauth_token = SalesforceChatter.oauth_token
      SalesforceChatter.reset
      
      
      SalesforceChatter.configure do |config|
        config.consumer_key    = ""
        config.consumer_secret = ""
        config.username        = ""
        config.password        = ""
        config.endpoint        = ""
        config.security_token  = ""
        config.oauth_token     = oauth_token
      end
      
      SalesforceChatter.feed_items.class.should == Hashie::Mash
    end
  end

end

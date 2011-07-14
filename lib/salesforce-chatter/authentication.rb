module SalesforceChatter

  module Authentication

    def authenticate(options={})
      options[:client_id]     = SalesforceChatter.consumer_key
      options[:client_secret] = SalesforceChatter.consumer_secret
      options[:username]      = SalesforceChatter.username
      options[:password]      = SalesforceChatter.password + SalesforceChatter.security_token
      options[:grant_type]    = 'password'

      response = post('services/oauth2/token', options)
      SalesforceChatter.oauth_token = response.access_token
      response
    end
    

    def authentication
      {
        :consumer_key => consumer_key,
        :consumer_secret => consumer_secret,
        :token => oauth_token,
        :token_secret => oauth_token_secret
      }
    end

    def authenticated?
      !SalesforceChatter.oauth_token.nil?
    end

  end

end

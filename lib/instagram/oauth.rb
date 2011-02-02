module Instagram
  # Defines HTTP request methods
  module OAuth
    # Return URL for OAuth authorization
    def authorize_url(options={})
      options[:response_type] = options[:response_type] || "code"
      params = access_token_params.merge(options)
      connection.build_url("/oauth/authorize/", params).to_s
    end
    
    # Return an access token from authorization
    def get_access_token(code, options={})
      options[:grant_type] = options[:grant_type] || "authorization_code"
      params = {:code => code}.merge(access_token_params).merge(options)
      response = post("/oauth/access_token/", params, raw=false, unformatted=true)
      response[:access_token]
    end
    
    private
    
    def access_token_params
      {
        :client_id => client_id,
        :client_secret => client_secret
      }
    end
  end
end

require 'net/http'
require 'net/https'
require 'uri'
require 'json'
require 'cgi'
require 'singleton'
require 'active_support' # String conversions

module WepayClient
  class Client
    include Singleton

    STAGE_API_ENDPOINT = "https://stage.wepayapi.com/v2"
    STAGE_UI_ENDPOINT = "https://stage.wepay.com/v2"

    PRODUCTION_API_ENDPOINT = "https://wepayapi.com/v2"
    PRODUCTION_UI_ENDPOINT = "https://www.wepay.com/v2"

    CLIENT_ID              = '123456'
    CLIENT_SECRET          = '123456'

    def self.configure(&blk)
      self.instance.configure &blk
    end

    # Simple DSL to configure the client.
    def configure(&blk)
      instance_eval &blk
    end

    def api_endpoint
      if @use_stage
        STAGE_API_ENDPOINT
      else
        PRODUCTION_API_ENDPOINT
      end
    end

    def ui_endpoint
      if @use_stage
        STAGE_UI_ENDPOINT
      else
        PRODUCTION_UI_ENDPOINT
      end
    end

    def use_stage(_use_stage = nil)
      @use_stage = _use_stage if _use_stage
      @use_stage
    end

    def use_ssl(_use_ssl = nil)
      @use_stage = _use_ssl if _use_ssl
      @use_stage
    end

    def client_secret(secret = nil)
      @client_secret = secret if secret
      @client_secret
    end

    def client_id(_client_id = nil)
      @client_id = _client_id if _client_id
      @client_id
    end

    # this function returns the URL that you send the user to to authorize your API application
    # the redirect_uri must be a full uri (ex https://www.wepay.com)
    def auth_code_url(redirect_uri, user_email = false, user_name = false, permissions = "manage_accounts,view_balance,collect_payments,refund_payments,view_user,preapprove_payments")
      url = ui_endpoint + '/oauth2/authorize?client_id=' + client_id.to_s + '&redirect_uri=' + redirect_uri + '&scope=' + permissions
      url += user_name ? '&user_name=' + CGI::escape(user_name) : ''
      url += user_email ? '&user_email=' + CGI::escape(user_email) : ''
    end

    # this function will make a call to the /v2/oauth2/token endpoint to exchange a code for an access_token
    def get_access_token(auth_code, redirect_uri)
      json = post('/oauth2/token', nil, {'client_id' => client_id, 'client_secret' => client_secret, 'redirect_uri' => redirect_uri, 'code' => auth_code })
      raise WepayClient::Exceptions::AccessTokenError.new("A problem occurred trying to get the access token: #{json.inspect}") unless json.has_key?(:access_token)
      json[:access_token]
    end

    protected

    def request(type, endpoint, access_token, body = nil)
      uri = URI.parse(api_endpoint + endpoint)
      http = Net::HTTP.new(uri.host, uri.port)
      http.use_ssl = use_ssl

      # construct the call data and access token
      req = Net::HTTP.const_get(type.to_s.camelize).new(uri.request_uri, initheader = {'Content-Type' =>'application/json', 'User-Agent' => 'WePay Ruby SDK'})
      req.add_field('Authorization: Bearer', access_token) if access_token
      req.body = body.to_json if body
      http.request(req)
    end

    def post(endpoint, access_token, params)
      res = request(:post, endpoint, access_token, params)
      handle_response res
    end

    def handle_response(response)
      begin
        json = symbolize_response(response.body)
      rescue Errno, JSON::ParserError => e
        raise WepayClient::Exceptions::WepayApiError.new("The request to WePay timed out. This might mean you sent an invalid request or WePay is having issues.")
      rescue => e
        raise e if e.class.to_s =~ /WepayClient/
        raise WepayClient::Exceptions::WepayApiError.new("There was an error while trying to connect with WePay - #{e.inspect}")
      end
      if response.kind_of?(Net::HTTPSuccess)
        return json
      elsif response.code == 401
        raise WepayClient::Exceptions::ExpiredTokenError.new("Token either expired, revoked or invalid: #{json.inspect}.")
      else
        raise WepayClient::Exceptions::WepayApiError.new("The API request failed with error code ##{response.code}: #{json.inspect}.")
      end
    end

    def symbolize_response(response)
      json = JSON.parse(response)
      if json.kind_of? Hash
        json.symbolize_keys! and raise_if_response_error(json)
      elsif json.kind_of? Array
        json.each{|h| h.symbolize_keys!}
      end
      json
    end

    def raise_if_response_error(json)
      if json.has_key?(:error) && json.has_key?(:error_description)
        if ['invalid code parameter','the code has expired','this access_token has been revoked', 'a valid access_token is required'].include?(json[:error_description])
          raise WepayClient::Exceptions::ExpiredTokenError.new("Token either expired, revoked or invalid: #{json[:error_description]}")
        else
          raise WepayClient::Exceptions::WepayApiError.new(json[:error_description])
        end
      end
    end

  end
end
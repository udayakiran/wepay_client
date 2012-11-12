module WepayClient
  module Exceptions
    class AccessTokenError < StandardError; end
    class ExpiredTokenError < StandardError; end
    class InitializeCheckoutError < StandardError; end
    class AuthorizationError < StandardError; end
    class WepayCheckoutError < StandardError; end
    class WepayApiError < StandardError; end
  end
end
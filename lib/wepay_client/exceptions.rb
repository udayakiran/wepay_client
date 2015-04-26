module WepayClient
  module Exceptions
    class AccessTokenError < BaseError; end
    class ExpiredTokenError < BaseError; end
    class InitializeCheckoutError < BaseError; end
    class AuthorizationError < BaseError; end
    class WepayCheckoutError < BaseError; end
    class WepayApiError < BaseError; end
  end
end

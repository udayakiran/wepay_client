module WepayClient
  class BaseError < StandardError
  
    def initialize(message = '', code = nil)
      @error_message = message
      @error_code = code
    end
  
    def message
      @error_message
    end
  
    def code
      @error_code.to_s
    end
  end
end

module WepayClient
  class Client
    def get_checkout(access_token, checkout_id)
      self.post("/checkout", access_token, {:checkout_id => checkout_id})
    end

    def create_checkout(access_token, params = {})
      defaults = {
          :type => 'SERVICE',
          :fee => { 
                    :app_fee => 0,
                    :fee_payer => 'Payee'
                  },
          :auto_capture => true
      }.merge(params)
      self.post("/checkout/create", access_token, defaults.merge(params))
    end

    def refund(access_token, checkout_id, params = {})
      self.post("/checkout/refund", access_token, params.merge(:checkout_id => checkout_id))
    end
  end
end

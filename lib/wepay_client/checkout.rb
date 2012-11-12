module WepayClient
  class Client
    def get_checkout(access_token, checkout_id)
      self.post("/checkout", access_token, {:checkout_id => checkout_id})
    end

    def create_checkout(access_token, params = {})
      defaults = {
          :fee_payer => 'Payee',
          :type => 'SERVICE',
          :charge_tax => 0,
          :app_fee => 0,
          :auto_capture => 1,
          :require_shipping => 0
      }.merge(params)
      self.post("/checkout/create", access_token, defaults)
    end

    def refund(access_token, checkout_id, params = {})
      self.post("/checkout/refund", access_token, params.merge(:checkout_id => checkout_id))
    end
  end
end
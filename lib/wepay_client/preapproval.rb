module WepayClient
  class Client
    PREAPPROVAL_PERIODS = {
      :hourly   => 'hourly',
      :daily    => 'daily',
      :weekly   => 'weekly',
      :biweekly => 'biweekly',
      :monthly  => 'monthly',
      :quarterly=> 'quarterly',
      :yearly   => 'yearly',
      :once     => 'once'
    }

    def create_preapproval(access_token, params = {})
      defaults = {
        :frequency => 10
      }.merge(params)

      self.post("/preapproval/create", access_token, defaults)
    end

    def get_preapproval(access_token, preapproval_id)
      self.post("/preapproval", access_token, {:preapproval_id => preapproval_id})
    end

    def cancel_preapproval(access_token, preapproval_id)
      self.post("/preapproval/cancel", access_token, {:preapproval_id => preapproval_id})
    end
  end
end
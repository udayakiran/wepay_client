module WepayClient
  class Client
    def create_account(access_token, params = {})
      self.post("/account/create", access_token, params)
    end

    def get_account(access_token, account_id)
      self.post("/account", access_token, {:account_id => account_id})
    end

    def find_account(access_token, params = {})
      self.post("/account/find", access_token, params)
    end

    def modify_account(access_token, account_id, params={})
      self.post("/account/modify", access_token, params.merge({:account_id => account_id}))
    end

    def delete_account(access_token, account_id)
      self.post("/account/delete", access_token, {:account_id => account_id})
    end

    def get_account_balance(access_token, account_id)
      self.post("/account/balance", access_token, {:account_id => account_id})
    end
  end
end
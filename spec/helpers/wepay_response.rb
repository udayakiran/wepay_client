module WepayResponse
  def response_for_access_token
    load_resp 'access_token_success.json'
  end

  def response_for_create_account
    load_resp 'account_creation_success.json'
  end

  def load_resp(file_name)
    file_path = File.expand_path("../../wepay_response/#{file_name}", __FILE__)
    json = File.open(file_path, "r").read
    json
  end
end
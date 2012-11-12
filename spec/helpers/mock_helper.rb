module MockHelper
  def return_json_for_api_request(body, is_success = true)
    WepayClient::Client.instance.stub(:request => mock({:body => body, 'success?' => is_success}))
  end
end

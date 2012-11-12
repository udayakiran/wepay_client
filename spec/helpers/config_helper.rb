module ConfigHelper
  def configure_client
    WepayClient::Client.configure do
      client_id     WepayClient::Client::CLIENT_ID
      client_secret WepayClient::Client::CLIENT_SECRET
      use_ssl       true
    end
  end
end

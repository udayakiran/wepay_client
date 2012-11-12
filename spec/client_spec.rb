require 'spec/spec_helper'

describe 'WepayClient::Client' do
  before(:all) do
    configure_client
    @client = WepayClient::Client.instance
  end

  it 'should return proper auth_code_url' do
    url = @client.auth_code_url 'http://test.com'
    url.should_not be_nil
  end

  it 'should return access_token on get_access_token' do
    return_json_for_api_request response_for_access_token
    access_token = @client.get_access_token '123456', 'http://test.com'
    access_token.should_not be_nil
  end

  it 'should raise AccessTokenError exception if access_token is not return by get_access_token' do
    return_json_for_api_request "{}"
    lambda { @client.get_access_token '123456', 'http://test.com' }.should raise_error(WepayClient::Exceptions::AccessTokenError)
  end

  it 'should create an account on create_account' do
    return_json_for_api_request response_for_create_account

    account_resp = @client.create_account '123456',{
        "name" => "Example Account",
        "description" => "This is just an example WePay account.",
        "reference_id" => "abc123",
        "image_uri" => "https://stage.wepay.com/img/logo.png"
    }

    account_resp.should_not be_nil
    account_resp[:account_id].should_not be_nil
  end
end
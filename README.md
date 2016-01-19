
# wepay_client

This is a simple ruby client to interact with wepay apis.

Supports version 2015-11-18 (https://www.wepay.com/developer/version), the latest version to the date.

Please check the branches for the older versions' support if needed.

## Setup and usage

### Setup

In rails put following in Gemfile

```
gem 'wepay_client',:git => 'git://github.com/udayakiran/wepay_client.git'
```
### Usage

Create a wepay_config.rb in config/initializers folder and setup the client with wepay client id and client secret

```
require 'wepay_client'

WepayClient::Client.configure do
  client_id     '11111111'
  client_secret '5f434343'
  use_ssl       true
  use_stage     !(ENV['RAILS_ENV'] == 'production')
end

```
An example to call wepay apis

```
wepay = WepayClient::Client.instance
account = wepay.create_account('token data', 1122334)
p account[:account_id]
```

## References

Wepay developers site - https://www.wepay.com/developer

### Note

Wepay provides a ruby SDK for the same purpose - https://github.com/wepay/ruby-sdk

wepay's SDK can be used if you find it more comfortable. We started this wepay_client gem during the initial days when there was no ruby SDK from wepay. There are a few differences in the design and i think we are doing a little better job of handling exceptions and conveting response to proper ruby objects.

However, both of these sever the same purpose. So, either can be chosen without a thought. We try our best to keep this gem up to date and well maintained.

## Contributing

Please help with your contribution by filing any issues if found. Pull requests are welcomed :)

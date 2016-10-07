require 'webmock/rspec'
WebMock.disable_net_connect!(allow_localhost: true)

RSpec.configure do |config|
  config.before(:each) do
    body_fixer =
      '{"base":"EUR","date":"2016-10-05","rates":{"RUB":69.9836,"USD":1.1211}}'
    stub_request(:get, /api.fixer.io/)
      .to_return(status: 200, body: body_fixer, headers: {})

    stub_request(:get, %r{www.random.org\/integers})
      .to_return(status: 200, body: '199\n', headers: {})
  end
end

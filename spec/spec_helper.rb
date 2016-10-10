require 'webmock/rspec'
WebMock.disable_net_connect!(allow_localhost: true)

RSpec.configure do |config|
  config.before(:each) do
    AppError.create!(kind: :min_bet_amount_is_not_reached, message: 'Min bet amount is not reached')
    AppError.create!(kind: :max_bet_amount_exceeded, message: 'Max bet amount exceeded')
    AppError.create!(kind: :insufficient_funds_in_account, message: 'Insufficient funds in the account')
    AppError.create!(kind: :user_in_blacklist, message: 'User in blacklist')

    body_fixer =
      '{"base":"EUR","date":"2016-10-05","rates":{"RUB":69.9836,"USD":1.1211}}'
    stub_request(:get, /api.fixer.io/)
      .to_return(status: 200, body: body_fixer, headers: {})

    stub_request(:get, %r{www.random.org\/integers})
      .to_return(status: 200, body: '199\n', headers: {})
  end
end

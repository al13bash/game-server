FactoryGirl.define do
  factory :currency_exchange do
    initialize_with { CurrencyExchange.instance }
    usd 1.1211
    rub 69.9836
  end
end

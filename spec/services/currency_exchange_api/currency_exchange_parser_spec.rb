require 'rails_helper'

RSpec.describe CurrencyExchangeApi::CurrencyExchangeParser do
  describe 'fetches currency exchange rates' do
    it 'updates CurrencyExchange instance' do
      described_class.parse
      expect(CurrencyExchange.instance.usd.to_f).to eq(1.1211)
      expect(CurrencyExchange.instance.rub.to_f).to eq(69.9836)
    end
  end
end

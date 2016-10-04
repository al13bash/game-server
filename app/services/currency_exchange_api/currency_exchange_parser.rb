module CurrencyExchangeApi
  class CurrencyExchangeParser
    API_URL = 'http://api.fixer.io/latest'

    class << self
      def parse
        response = RestClient.get API_URL
        response_hash = JSON.parse(response.body)
        usd = response_hash['rates']['USD']
        rub = response_hash['rates']['RUB']

        update_currency_instance(usd, rub)
      end

      def update_currency_instance(usd, rub)
        CurrencyExchange.instance.update(usd: usd, rub: rub)
      end
    end
  end
end

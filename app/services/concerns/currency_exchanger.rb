module Concerns
  module CurrencyExchanger
    def exchange_to_eur(amount)
      currency_code = amount.currency.iso_code
      return amount if currency_code == 'EUR'

      rate = CurrencyExchange.instance.send(currency_code.downcase)
      rate = 1.0 / rate
      Money.add_rate(currency_code, 'EUR', rate)

      amount.exchange_to('EUR')
    end
  end
end

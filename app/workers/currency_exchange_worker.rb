class CurrencyExchangeWorker
  include Sidekiq::Worker

  sidekiq_options queue: :currency

  sidekiq_options retry: 5

  def perform
    CurrencyExchangeApi::CurrencyExchangeParser.parse
  end
end

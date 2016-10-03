class CurrencyExchangeWorker
  include Sidekiq::Worker
  sidekiq_options queue: :currency

  def perform
    CurrencyExchangeApi::CurrencyExchangeParser.parse
  end
end

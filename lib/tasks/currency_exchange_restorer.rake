namespace :currency do
  desc 'Restore currency table'
  task restore_exchange: :environment do
    CurrencyExchangeWorker.perform_async
  end
end

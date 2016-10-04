class CurrencyExchange < ApplicationRecord
  include ActiveRecord::Singleton

  BASE_CURRENCY = 'EUR'.freeze
end

class GameService < ApplicationRecord
  include ActiveRecord::Singleton

  monetize :revenue_amount_cents, as: :revenue_amount,
                                  with_model_currency: :revenue_amount_currency
end

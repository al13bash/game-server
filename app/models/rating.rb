class Rating < ApplicationRecord
  RATING_TOP_AMOUNT = 10

  belongs_to :game

  scope :top, -> { limit(RATING_TOP_AMOUNT) }

  monetize :score_cents, as: :score,
                              with_model_currency: :score_currency
end

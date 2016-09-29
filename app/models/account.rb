class Account < ApplicationRecord
  belongs_to :user

  monetize :amount_cents, with_model_currency: :amount_currency,
                          as: :amount,
                          numericality: { greater_than_or_equal_to: 0 }
end

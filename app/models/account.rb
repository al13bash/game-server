class Account < ApplicationRecord
  belongs_to :user

  monetize :amount_money, with_model_currency: :currency, as: :amount,
                          numericality: { greater_than_or_equal_to: 0 }
end

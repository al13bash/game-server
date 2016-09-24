class Account < ApplicationRecord
  belongs_to :user

  monetize :amount_money, as: :amount, numericality: { greater_than_or_equal_to: 0 }
end

class Account < ApplicationRecord
  belongs_to :user

  validates :active, uniqueness: { scope: :user_id}, if: :active

  monetize :amount_money, as: :amount, numericality: { greater_than_or_equal_to: 0 }
end

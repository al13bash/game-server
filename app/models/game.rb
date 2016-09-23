class Game < ApplicationRecord
  belongs_to :user

  validates :bet_amount_money, :win_amount_money,
            numericality: { greater_than_or_equal_to: 0 }

  monetize :bet_amount_money, as: :bet_amount
  monetize :win_amount_money, as: :win_amount
end

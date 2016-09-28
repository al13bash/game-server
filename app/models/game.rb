class Game < ApplicationRecord
  include AASM

  belongs_to :user

  validates :bet_amount_money, :win_amount_money,
            numericality: { greater_than_or_equal_to: 0 }

  monetize :bet_amount_money, as: :bet_amount
  monetize :win_amount_money, as: :win_amount

  aasm column: 'status' do
    state :pending, initial: true
    state :failure, :in_progress, :done

    event :fail do
      transitions from: [:pending, :in_progress], to: :failure
    end

    event :proceed do
      transitions from: :pending, to: :in_progress
    end

    event :complete do
      transitions from: :in_progress, to: :done
    end
  end
end

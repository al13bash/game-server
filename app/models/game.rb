class Game < ApplicationRecord
  include AASM

  belongs_to :user
  belongs_to :account
  has_many :ratings, dependent: :destroy

  validates :bet_amount_cents, :win_amount_cents,
    numericality: { greater_than_or_equal_to: 0 }

  scope :last_twenty, -> { order(created_at: :desc).first(20) }

  monetize :bet_amount_cents, as: :bet_amount,
                              with_model_currency: :bet_amount_currency
  monetize :win_amount_cents, as: :win_amount,
                              with_model_currency: :win_amount_currency

  aasm column: 'status' do
    state :pending, initial: true
    state :failure, :in_validation, :in_progress, :done

    event :fail do
      transitions from: [:pending, :in_progress, :in_validation], to: :failure
    end

    event :run_validation do
      transitions from: :pending, to: :in_validation
    end

    event :proceed do
      transitions from: :in_validation, to: :in_progress
    end

    event :complete do
      transitions from: :in_progress, to: :done
    end
  end
end

class User < ApplicationRecord
  has_many :accounts
  has_many :games

  after_create :create_account_for_user

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  private

  def create_account_for_user
    accounts.build(amount_cents: 1_000_000, amount_currency: 'EUR')
    accounts.build(amount_cents: 1_000_000, amount_currency: 'USD')
    accounts.build(amount_cents: 1_000_000, amount_currency: 'RUB')
    accounts.build(amount_cents: 1_000_000, amount_currency: 'BYN')
  end
end

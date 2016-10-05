class User < ApplicationRecord
  has_many :accounts
  has_many :games

  after_create :create_account_for_user

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  def ordered_accounts
    accounts.order({ amount_currency: :asc })
  end

  def accounts_hash
    ordered_accounts.inject(Hash.new(0)) do |hash, account|
      hash[account.id] = {
        id: account.id,
        amount: account.amount.format,
        amount_currency: account.amount.currency.iso_code
      }
      hash
    end
  end

  private

  def create_account_for_user
    accounts.build(amount_cents: 1_000_000, amount_currency: 'EUR')
    accounts.build(amount_cents: 1_000_000, amount_currency: 'USD')
    accounts.build(amount_cents: 1_000_000, amount_currency: 'RUB')
  end
end

class User < ApplicationRecord
  has_many :accounts
  has_many :games

  after_create :create_account_for_user

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  private

  def create_account_for_user
    accounts.build(amount_money: 100_000, currency: 'EUR')
  end
end

class User < ApplicationRecord
  after_create :create_account_for_user

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :accounts
  has_many :games

  private

  def create_account_for_user
    self.accounts.build(amount_money: 100_000, active: true)
  end
end

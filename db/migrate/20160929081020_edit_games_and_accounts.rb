class EditGamesAndAccounts < ActiveRecord::Migration[5.0]
  def change
    add_monetize :accounts, :amount

    add_monetize :games, :bet_amount
    add_monetize :games, :win_amount
  end
end

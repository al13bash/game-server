class AddAccountRefToGames < ActiveRecord::Migration[5.0]
  def change
    add_reference :games, :account
  end
end

class AddValidationsCountToGames < ActiveRecord::Migration[5.0]
  def change
    add_column :games, :validations_count, :integer
  end
end

class EditGame < ActiveRecord::Migration[5.0]
  def change
    change_column :games, :id, :integer, limit: 8
    add_column :games, :finished_at, :datetime
    add_column :games, :status, :string
  end
end

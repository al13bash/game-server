class CreateRatings < ActiveRecord::Migration[5.0]
  def change
    create_table :ratings do |t|
      t.belongs_to :game
      t.monetize :score

      t.timestamps
    end
  end
end

class CreateGames < ActiveRecord::Migration[5.0]
  def change
    create_table :games do |t|
      t.money      :bet_amount_money
      t.money      :win_amount_money
      t.references :user

      t.timestamps
    end
  end
end

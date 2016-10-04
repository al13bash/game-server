class CreateGameServices < ActiveRecord::Migration[5.0]
  def change
    create_table :game_services do |t|
      t.monetize :revenue_amount
      t.integer  :min_bet_amount_cents, default: 1000

      t.timestamps
    end
  end
end

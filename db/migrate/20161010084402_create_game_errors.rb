class CreateGameErrors < ActiveRecord::Migration[5.0]
  def change
    create_table :game_errors do |t|
      t.references :game, foreign_key: true
      t.references :app_error, foreign_key: true

      t.timestamps
    end
  end
end

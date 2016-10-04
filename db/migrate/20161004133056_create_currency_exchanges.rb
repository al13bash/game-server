class CreateCurrencyExchanges < ActiveRecord::Migration[5.0]
  def change
    create_table :currency_exchanges do |t|
      t.decimal :usd
      t.decimal :rub
      t.timestamps
    end
  end
end

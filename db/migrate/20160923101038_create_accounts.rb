class CreateAccounts < ActiveRecord::Migration[5.0]
  def change
    create_table :accounts do |t|
      t.money      :amount_money
      t.boolean    :active, null: false, default: false
      t.references :user

      t.timestamps
    end
  end
end

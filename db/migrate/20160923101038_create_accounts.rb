class CreateAccounts < ActiveRecord::Migration[5.0]
  def change
    create_table :accounts do |t|
      t.integer    :amount
      t.string     :currency,  limit: 3
      t.references :user

      t.timestamps
    end
  end
end

class EditAccounts < ActiveRecord::Migration[5.0]
  def change
    remove_column :accounts, :active
    add_column :accounts, :currency, :string
  end
end

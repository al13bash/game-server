class CreateAppErrors < ActiveRecord::Migration[5.0]
  def change
    create_table :app_errors do |t|
      t.string :kind
      t.text :message

      t.timestamps
    end
  end
end

class CreateCustomers < ActiveRecord::Migration[7.2]
  def change
    create_table :customers do |t|
      t.string :name, null: false
      t.string :email, null: false, index: true
      t.string :phone, null: false, index: true

      t.index [ :email, :phone ], unique: true
      t.timestamps
    end
  end
end

class CreateProducts < ActiveRecord::Migration[7.2]
  def change
    create_table :products do |t|
      t.string :name
      t.decimal :price, default: 0, precision: 10, scale: 2
      t.integer :stock, default: 0

      t.timestamps
    end
  end
end

class CreateOrderItems < ActiveRecord::Migration[7.2]
  def change
    create_table :order_items do |t|
      t.references :order, null: false, foreign_key: true
      t.references :product, null: false, foreign_key: true
      t.integer :quantity, default: 0
      t.decimal :price, default: 0, precision: 10, scale: 2

      t.timestamps
    end
  end
end

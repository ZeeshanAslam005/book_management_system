class CreateOrders < ActiveRecord::Migration
  def change
    create_table :orders do |t|
      t.integer :user_id, null: false         # Customer who placed the order
      t.integer :book_id, null: false         # Book being purchased
      t.integer :quantity, null: false        # Quantity of books purchased
      t.decimal :total_price, precision: 10, scale: 2, null: false # Total price

      t.timestamps null: false
    end

    # Add indexes for faster lookups
    add_index :orders, :user_id
    add_index :orders, :book_id
  end
end

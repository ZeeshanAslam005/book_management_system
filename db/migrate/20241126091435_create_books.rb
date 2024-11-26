class CreateBooks < ActiveRecord::Migration
  def change
    create_table :books do |t|
      t.string :title, null: false            # Title of the book
      t.string :author, null: false           # Author of the book
      t.decimal :price, precision: 10, scale: 2, null: false  # Price of the book
      t.integer :bookstore_id                 # Foreign key for Bookstore
      t.date :published_date                  # Publication date of the book

      t.timestamps null: false                # Rails 4.2 compatible timestamps
    end

    # Add index for faster lookups on bookstore_id
    add_index :books, :bookstore_id
  end
end


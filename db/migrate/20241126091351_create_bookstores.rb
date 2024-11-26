class CreateBookstores < ActiveRecord::Migration
  def change
    create_table :bookstores do |t|
      t.string :name, null: false              # Name of the bookstore
      t.string :location                      # Location of the bookstore
      t.integer :manager_id                   # ID of the manager (User)

      t.timestamps null: false                # Rails 4.2 compatible timestamps
    end

    # Add index for faster lookups on manager_id
    add_index :bookstores, :manager_id
  end
end

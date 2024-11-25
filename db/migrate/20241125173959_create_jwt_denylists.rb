class CreateJwtDenylists < ActiveRecord::Migration
  def change
    create_table :jwt_denylists do |t|

      t.timestamps null: false
    end
  end
end

class CreateBooks < ActiveRecord::Migration
  def up
    create_table :books , id: false do |t|
      
      t.integer :isbn
      t.string :name
      t.text :authors
      t.timestamps null: false
      t.primary_key :isbn
    end
  end
  def down
  	drop_table :books
  end
end

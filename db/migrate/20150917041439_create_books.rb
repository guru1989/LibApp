class CreateBooks < ActiveRecord::Migration
  def up
    create_table :books do |t|
      t.integer :isbn
      t.string :name
      t.text :authors

      t.timestamps null: false
    end
  end
  def down
    drop_table :books
  end
end

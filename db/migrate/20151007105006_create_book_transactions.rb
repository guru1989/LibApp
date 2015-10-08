class CreateBookTransactions < ActiveRecord::Migration
  def up
    create_table :book_transactions do |t|
      t.column :book_id, :integer
      t.column :member_id, :integer
      t.timestamps null: false
    end
  end
  def down
    drop_table :book_transactions
  end
end
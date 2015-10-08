class AddStatusToBooks < ActiveRecord::Migration
  def up
    add_column :books, :status, :string, default: "Available"
  end
  def down
    remove_column :books, :status
  end
end
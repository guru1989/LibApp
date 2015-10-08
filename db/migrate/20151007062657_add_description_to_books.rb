class AddDescriptionToBooks < ActiveRecord::Migration
  def change
    add_column :books, :description, :string, default: "Description yet to be added"
  end
end
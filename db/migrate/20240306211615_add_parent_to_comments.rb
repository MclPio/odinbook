class AddParentToComments < ActiveRecord::Migration[7.0]
  def change
    add_column :comments, :parent_id, :integer, default: nil
    add_index :comments, :parent_id
    add_foreign_key :comments, :comments, column: :parent_id
    add_column :comments, :depth, :integer, default: 0
  end
end

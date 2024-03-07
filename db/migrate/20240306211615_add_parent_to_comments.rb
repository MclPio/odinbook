class AddParentToComments < ActiveRecord::Migration[7.0]
  def change
    add_column :comments, :parent_id, :integer, null: true
    add_index :comments, :parent_id
    add_column :comments, :depth, :integer, default: 0
    add_check_constraint :comments, 'depth >= 0 AND depth <= 1', name: 'depth_limit'
  end
end

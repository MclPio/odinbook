class AddUniqueIndexToPolyLikes < ActiveRecord::Migration[7.0]
  def change
    add_index :poly_likes, [:user_id, :likable_type, :likable_id], unique: true
  end
end

class AddCounterCacheToPosts < ActiveRecord::Migration[7.0]
  def change
    add_column :posts, :comments_count, :integer, default: 0
    add_column :posts, :poly_likes_count, :integer, default: 0
  end
end

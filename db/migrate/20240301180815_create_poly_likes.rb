class CreatePolyLikes < ActiveRecord::Migration[7.0]
  def change
    create_table :poly_likes do |t|
      t.references :likable, polymorphic: true, null: false
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end

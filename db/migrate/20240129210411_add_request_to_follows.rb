class AddRequestToFollows < ActiveRecord::Migration[7.0]
  def change
    add_column :follows, :approved, :boolean, default: false
  end
end

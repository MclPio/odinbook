class Comment < ApplicationRecord
  belongs_to :user
  belongs_to :post, counter_cache: true
  has_many :poly_likes, as: :likable, dependent: :destroy
  belongs_to :parent, class_name: 'Comment', optional: true
  has_many :comments, foreign_key: :parent_id, dependent: :destroy

  validates :body, presence: true, length: { maximum: 280 }
  validates :depth, numericality: { greater_than_or_equal_to: 0, less_than_or_equal_to: 1 }
end

class Comment < ApplicationRecord
  belongs_to :user
  belongs_to :post, counter_cache: true
  has_many :poly_likes, as: :likable

  validates :body, presence: true, length: { maximum: 280 }
end

class Like < ApplicationRecord
  belongs_to :post, counter_cache: true
  belongs_to :user

  validates :user_id, uniqueness: { scope: :post_id, message: 'Can only like once' }
end

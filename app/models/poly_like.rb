class PolyLike < ApplicationRecord
  belongs_to :likable, polymorphic: true, counter_cache: true
  belongs_to :user

  validates :user_id, uniqueness: { scope: [:likable_type, :likable_id], message: "duplicate like" }
end

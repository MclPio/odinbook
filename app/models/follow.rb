class Follow < ApplicationRecord
  belongs_to :follower, foreign_key: 'follower_id', class_name: 'User'
  belongs_to :followee, foreign_key: 'followee_id', class_name: 'User'

  validates :follower_id, uniqueness: { scope: :followee_id, message: 'Can only follow once' }
  validate :cannot_follow_self

  private

  def cannot_follow_self
    errors.add(:base, 'You cannot follow yourself') if follower_id == followee_id
  end
end

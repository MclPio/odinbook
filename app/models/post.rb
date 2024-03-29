class Post < ApplicationRecord
  belongs_to :user
  has_many :poly_likes, as: :likable
  has_many :comments, dependent: :destroy

  validates :body, presence: true, length: { maximum: 280 },
            format: { with: /\b\w{1,50}\b/, 
                      message: "cannot contain more than 50 consecutive non-space characters" }
end

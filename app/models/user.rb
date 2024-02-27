class User < ApplicationRecord
  after_create :welcome_email
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :omniauthable, omniauth_providers: [:google_oauth2]

  def self.from_omniauth(auth)
    find_or_create_by(provider: auth.provider, uid: auth.uid) do |user|
      user.email = auth.info.email
      user.password = Devise.friendly_token[0, 20]
      user.full_name = auth.info.name # assuming the user model has a name
      user.avatar_url = auth.info.image # assuming the user model has an image
      user.username = auth.info.name + auth.uid.to_s + srand.to_s
      # If you are using confirmable and the provider(s) you use validate emails,
      # uncomment the line below to skip the confirmation emails.
      # user.skip_confirmation!
    end
  end

  validates :username, presence: true, uniqueness: true
  validates :email, presence: true, uniqueness: true

  has_many :follower_follows, foreign_key: :followee_id, class_name: 'Follow'
  has_many :followers, through: :follower_follows, source: :follower, dependent: :destroy

  has_many :followee_follows, foreign_key: :follower_id, class_name: 'Follow'
  has_many :followees, through: :followee_follows, source: :followee, dependent: :destroy

  has_many :posts, dependent: :destroy

  has_many :likes
  has_many :liked_posts, through: :likes, source: :post

  has_many :comments

  def welcome_email
    UserMailer.welcome_email(self).deliver_later
  end

  def follow(user)
    followees << user
  end

  def unfollow(user)
    followees.destroy(user)
  end

  def following?(user)
    followees.include?(user)
  end
end

class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :posts

  has_many :following_relationships, class_name: "Relationship", foreign_key: "follower_id", dependent: :destroy
  has_many :followed_users, through: :following_relationships, source: :followed

  has_many :follower_relationships, class_name: "Relationship", foreign_key: "followed_id", dependent: :destroy
  has_many :followers, through: :follower_relationships, source: :follower

  def following?(user)
    following_relationships.find_by(followed_id: user.id)
  end

  def follow!(user)
    following_relationships.create!(followed_id: user.id)
  end

  def unfollow!(user)
    following_relationships.find_by(followed_id: user.id).destroy
  end
end

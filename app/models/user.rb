class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  has_many :books, dependent: :destroy
  has_many :favorites, dependent: :destroy
  has_many :book_comments, dependent: :destroy
  has_many :follower, class_name: "Relationship", foreign_key: "follower_id", dependent: :destroy # ① フォローしている人取得(Userのfollowerから見た関係)
  has_many :followed, class_name: "Relationship", foreign_key: "following_id", dependent: :destroy # ② フォローされている人取得(Userのfolowedから見た関係)
  has_many :following_user, through: :follower, source: :follower # 自分がフォローしている人
  has_many :follower_user, through: :followed, source: :following # 自分をフォローしている人(自分がフォローされている人)


  attachment :profile_image
  validates :name, presence: true, length: {minimum: 2, maximum: 20}
  validates :introduction,length: {maximum: 50}
  validates :name, uniqueness: true

  def follow(other_user)
    unless self == other_user
      # self.follower.find_or_create_by(following_id: other_user.id)
      self.follower.create(following_id: other_user.id)
    end
  end

  def unfollow(other_user)
    relationship = self.follower.find_by(following_id: other_user.id)
    # relationship = self.relationships.find_by(follow_id: other_user.id)
    relationship.destroy if relationship
  end

  def following?(other_user)
    # self.following_user.include?(other_user)
    # byebug
    @user = Relationship.where(follower_id: self.id, following_id: other_user)
    if @user.present?
      return true
    else
      return false
    end
  end
end

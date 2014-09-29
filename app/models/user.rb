class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :confirmable
  has_many :posts
  has_many :comments
  has_many :votes, dependent: :destroy
  has_many :favorites, dependent: :destroy
  mount_uploader :avatar, AvatarUploader

  def role?(base_role)
    role == base_role.to_s
  end

  def favorited(post)
    self.favorites.where(post_id: post.id).first
  end

  def like!(post)
    likes_mananger = LikeManager.new(self, post)
    likes_mananger.like!
  end

  def unlike!(post)
    likes_manager = LikeManager.new(self, post)
    likes_manager.unlike!
  end

  def liked_posts(post)
    likes_manager = LikeManager.new(self, post)
    likes_manager.liked_posts
  end

  def likes_count_for_users(post)
    likes_manager = LikeManager.new(self, post)
    likes_manager.likes_count_for_users
  end

  def user_already_liked_post?(post)
    likes_manager = LikeManager.new(self, post)
    likes_manager.user_already_liked_post?
  end

  def voted(post)
    #voted should return whether the user has any posts
  end

  private

end


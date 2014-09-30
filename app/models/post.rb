class Post < ActiveRecord::Base
  has_many :comments, dependent: :destroy
  has_many :votes, dependent: :destroy
  has_many :favorites, dependent: :destroy
  belongs_to :user
  belongs_to :topic
  after_create :create_vote
  mount_uploader :image, ImageUploader

  default_scope { order('rank DESC') }
    scope :visible_to, -> (user) { user ? all : joins(:topic).where('topics.public' => true) }


  validates :title, length: { minimum: 5 }, presence: true
  validates :body, length: { minimum: 20 }, presence: true
  validates :topic_id, presence: true
  validates :user_id, presence: true

  def like_string_for(user)
    likes_manager = LikeManager.new(user, self)  
    like_string = ""
    if likes_manager.user_already_liked_post?
      like_string += "You"
    end

    random_liker = likes_manager.liking_users.shuffle.sample
    if random_liker.present?
      like_string += ", #{User.find(random_liker).name}"
    end

    if likes_manager.likes_count_for_post > 2
      like_string += " and #{likes_manager.likes_count_for_post - 2}"
    end

    if like_string.present?
      like_string += " like this post."
    end
    like_string
  end

  def up_votes
    self.votes.where(value: 1).count
  end

  def down_votes
    self.votes.where(value: -1).count
  end

  def points
    self.votes.sum(:value).to_i
  end

  def update_rank
    age = (self.created_at - Time.new(1970,1,1)) / 86400
    new_rank = points + age

    self.update_attribute(:rank, new_rank)
  end

  def liking_users(user)
    likes_manager = LikeManager.new(user, self)
    likes_manager.liking_users
  end

  def likes_count_for_post(user)
    likes_manager = LikeManager.new(user, self)
    likes_manager.likes_count_for_post
  end

  private

  def create_vote
    user.votes.create(value: 1, post: self)
  end
end


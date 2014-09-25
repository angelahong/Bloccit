=begin
  
LikeManager

like_manager = LikeManager.new(user, post)

  
=end
class LikeManager

  attr_reader :user, :post

  def initialize(user, post)
    @user = user
    @post = post
  end

  def like!
    REDIS.multi do
      REDIS.sadd post_key, user.id
      REDIS.sadd user_key, post.id
    end
    return true
  end

  def unlike!
    REDIS.multi do
      REDIS.srem post_key, user.id
      REDIS.srem user_key, post.id
    end
    return true
  end

  def liked_posts
    REDIS.smembers user_key
  end

  def liking_users
    REDIS.smembers post_key
  end

  def likes_count_for_post
    REDIS.scard post_key
  end

  def likes_count_for_user
    REDIS.scard user_key
  end

  def user_already_liked_post?
    REDIS.sismember post_key, user.id
  end

  protected

  # the list of posts the user liked
  def user_key
    "users:#{user.id}:liked_posts"
  end

  # the list of users that liked a post
  def post_key
    "posts:#{post.id}:liking_users"
  end

end

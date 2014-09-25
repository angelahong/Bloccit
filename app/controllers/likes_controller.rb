class LikesController < ApplicationController
  before_filter :authenticate_user!

  before_filter :initialize_members

  def create
    current_user.like!(@post)
    redirect_to :back
  end

  def destroy
    current_user.unlike!(@post)
    redirect_to :back
  end

  protected

  def initialize_members
    @topic = Topic.find(params[:topic_id])
    @post = @topic.posts.find(params[:post_id])
    
  end

end
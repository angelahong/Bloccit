class VotesController < ApplicationController
  before_filter :setup

  def up_vote
    update_vote(1)
    redirect_to :back
  end

  def down_vote
    update_vote(-1)
    redirect_to :back
  end

  private

  def setup
    #for all controllers, grab the parent objects
    @topic = Topic.find(params[:topic_id])
    @post = @topic.posts.find(params[:post_id])

    #look for existing votes by the user
    @vote = @post.votes.where(user_id: current_user.id).first
  end

  def update_vote(new_value)
    if @vote # if it exist, update it
      authorize @vote, :update?
      @vote.update_attribute(:value, 1)
    else
      @vote = current_user.votes.create(value: 1, post: @post)
      authorize @vote, :create?
      @vote.save
    end
  end
end

class CommentsController < ApplicationController

  before_filter :authenticate_user!
  
  def create
    @topic = Topic.find(params[:topic_id])
    @post = @topic.posts.find(params[:post_id])
    @comment = current_user.comments.build(comment_params)
    @comment.post = @post
    if @comment.save
      redirect_to topic_post_url(@topic, @post), notice: "Comment was saved successfully."
    else
      flash[:error] = "There was an error saving the comment. Please try again."
      render :new
    end
  end

  def comment_params
    params.require(:comment).permit(:body)
  end 
end

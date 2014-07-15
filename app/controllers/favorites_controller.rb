class FavoritesController < ApplicationController

  def create
    @topic = Topic.find(params[:topic_id])
    @post = @topic.posts.find(params[:post_id])
    favorite = current_user.favorites.build(post: @post)

    # for the create action
    authorize favorite

    if favorite.save
      flash[:notice] = "Favorited post"
      redirect_to [@topic, @post]
    else
      flash[:error] = "Unable to add favorite. Please try again."
      redirect_to [@topic, @post]
    end
  end

  def destroy
    @topic = Topic.find(params[:topic_id])
    @post = @topic.posts.find(params[:post_id])
    favorite = current_user.favorites.find(params[:id])

    # for the destroy action
    authroize favorite
    
    if favorite.destroy
      flash[:notice] = "Removed favorite"
      redirect_to [@topic, @post]
    else
      flash[:error] = "Unable to remove favorite. Please try again."
      redirect_to [@topic, @post]
    end
  end
end

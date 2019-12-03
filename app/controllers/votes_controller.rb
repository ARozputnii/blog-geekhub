class VotesController < ApplicationController
  before_action :find_post
  #before_action :find_comment

  def create
    if already_liked?
      flash[:notice] = "You can't like more than once"
    else
      @comment = Comment.find(params[:comment_id])
      @vote = @comment.votes.create(author: current_user)
    end
    redirect_to @post
  end


  def destroy
    @comment = Comment.find(params[:comment_id])
    Vote.find(params[:vote_id]).destroy
  end

  private

  def already_liked?
    Vote.where(author_id: current_user.id, comment_id:
        params[:comment_id]).exists?
  end

  def find_post
    @post = Post.find(params[:post_id])
  end


end


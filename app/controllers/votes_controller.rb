class VotesController < ApplicationController
  before_action :find_post
  before_action :find_vote, only: [:destroy]
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

  # dont work
  def destroy
    if !(already_liked?)
      flash[:notice] = "Cannot unlike"
    else
      @vote.destroy
    end
    redirect_to post_path(@post)
  end

  private
  # one author - one like
  def already_liked?
    Vote.where(author_id: current_user.id, comment_id:
        params[:comment_id]).exists?
  end

  def find_post
    @post = Post.find(params[:post_id])
  end

  def find_vote
    @vote = @post.comment.votes.find(params [:id])
  end

end


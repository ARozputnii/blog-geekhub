class VotesController < ApplicationController
  before_action :find_post
  before_action :find_comment
  before_action :find_vote, only: [:destroy]
  #before_action :find_comment

  def create
    if already_liked?
      flash[:notice] = "You can't like more than once"
    else
      # @comment = Comment.find(params[:comment_id])
      @comment.votes.create!(author: current_user, vote: 1)
      format.js { render 'comments/like', status: :created, location: @post }
    end
    redirect_to @post
  end

  # dont work
  def create_dis
    if already_liked?
      flash[:notice] = "You can't like more than once"
    else
      # @comment = Comment.find(params[:comment_id])
      @comment.votes.create!(author: current_user, value: 1)
      format.js { render 'comments/like', status: :created, location: @post }
    end
    redirect_to @post
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
  def find_comment
    @comment = Comment.find(params[:comment_id])
  end

  def find_vote
    @vote = @post.comment.votes.find(params [:id])
  end

end


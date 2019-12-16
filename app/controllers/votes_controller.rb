class VotesController < ApplicationController
  before_action :find_post
  before_action :find_comment

  def create
    if already_liked?
      redirect_to @post, alert: 'Вы уже оставляли оценку!'
    else
      respond_to do |format|
        if @comment.votes.create!(author: current_user, vote: 1)
          format.js { render 'comments/like', status: :created, location: @post }
        else
          format.html { redirect_to @post, alert: 'Вы уже оставляли оценку!' }
        end
      end
    end
  end

  def create_dis
    if already_liked?
      redirect_to @post, alert: 'You have already liked'
    else
      respond_to do |format|
        if @comment.votes.create!(author: current_user, value: 1)
          format.js { render 'comments/like', status: :created, location: @post }
        else
          format.html { redirect_to @post, alert: 'You have already liked' }
        end
      end
    end
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


end


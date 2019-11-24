class CommentsController < ApplicationController

  before_action :find_post
  before_action :find_comment, only: [:show, :edit, :update]

  def create
    @comment = @post.comments.create(comment_params)
    redirect_to post_path(@post)
  end

  def show
    @comment.destroy
    redirect_to post_path(@post)
  end

  def edit

  end

  def update
    if @comment.update(comment_params)
      redirect_to @post
    else
      render 'edit'
    end
  end
  private

  def find_post
    @post = Post.find(params[:post_id])
  end
  def find_comment
    @comment = @post.comments.find(params[:id])
  end
  def comment_params
    params.require(:comment).permit(:author_id, :body)
  end
end
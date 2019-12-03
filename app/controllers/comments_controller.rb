class CommentsController < ApplicationController

  before_action :require_login, only: %i[create edit update destroy]
  before_action :find_post
  before_action :find_comment, only: %i[show edit update destroy]
  before_action :owner, only: %i[edit update destroy]

  def index
    #подвязка к родетелю по даным дб
    @post.comments = @post.comments.arrange(order: :created_at)
  end

  def new
    # вложеные коментарии наследие гем ancestry
    @comment = Comment.new(parent_id: params[:parent_id])
  end

  def create
    if @current_user.baned == false
      @comment = @post.comments.create(comment_params)
      @comment.author_id = current_user.id
      respond_to do |format|
        if @comment.save
          format.html { redirect_to @post, notice: 'Comment was successfully created.' }
        else
          format.html { redirect_to @post, alert: 'Smth went wrong..' }
        end
      end
    end
  end

  def show
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

  def destroy
    respond_to do |format|
      if @comment.destroy
        format.html { redirect_to @post, notice: 'Comment was successfully destroyed.' }
      else
        format.html { redirect_to @post, alert: 'Smth went wrong..' }
      end
    end
  end

  private

  def find_post
    @post = Post.find(params[:post_id])
  end
  def find_comment
    @comment = @post.comments.find(params[:id])
  end
  def owner
    if( @comment.author_id == @current_user.id && @current_user.baned == false)
    else
      respond_to do |format|
        format.html { redirect_to @post, alert: 'You have no rights' }
      end
    end
  end
  def comment_params
    params.require(:comment).permit( :post_id, :body, :author_id, :parent_id)
  end
end
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
      if @comment.ancestors.count <= 4
        respond_to do |format|
          if @comment.save
            format.js { render 'create', status: :created, location: @post }
          else
            format.html { redirect_to @post, alert: @comment.errors.full_messages.first }
          end
        end
      else
        respond_to do |format|
          format.html { redirect_to @post, alert: 'To much comments in one tree (5 comments max)' }
        end
      end
    else
      redirect_to home_path, notice: 'Aborted. You are banned.'
    end
  end

  def edit
    respond_to do |format|
      format.js { render 'edit', status: :created, location: @post }
    end
  end

  def update
    respond_to do |format|
      if @comment.update(comment_params)
        format.js
        format.html { redirect_to @post, notice: 'Comment was successfully updated.' }
      else
        format.html { redirect_to @post, alert: 'Smth went wrong..' }
      end
    end
  end

  def destroy
    respond_to do |format|
      if @comment.destroy
        format.js { render 'destroy', status: :created, location: @post }
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
    if ( @comment.author_id == @current_user.id && @current_user.baned == false )
    else
      respond_to do |format|
        format.html { redirect_to @post, alert: 'У вас нет прав' }
      end
    end
  end
  def comment_params
    params.require(:comment).permit( :post_id, :body, :author_id, :parent_id)
  end
end
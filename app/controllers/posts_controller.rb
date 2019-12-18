class PostsController < ApplicationController
  impressionist actions: [:show]
  before_action :require_login, only: %i[create edit update destroy]
  before_action :set_post, only: %i[show edit update destroy]
  before_action :owner, only: %i[edit update destroy]

  def index
    # seach in db with paginate
    @posts = if params[:search]
               Post.search(params[:search]).order(created_at: :desc).paginate(page: params[:page], per_page: 3)
             else
               Post.all.order(created_at: :desc).paginate(page: params[:page], per_page: 3)
             end
    @post = Post.first
    @author = current_user
  end

  def show
    # counter
    impressionist(@post)
  end

  def new
    if current_user
      @post = Post.new
    else
      redirect_to login_path
    end
  end

  def edit; end

  def create
    if @current_user.baned == false
      @post = current_user.posts.build(post_params)
      respond_to do |format|
        if @post.save
          format.html { redirect_to @post, notice: 'Пост был успешно создан.' }
        else
          format.html { render :new }
        end
      end
    end
  end

  def update
    # If not a owner- you cant edit/destroy
    redirect_to root_path if owner == false
    respond_to do |format|
      if @post.update_attributes(post_params)
        format.html { redirect_to @post, notice: 'Пост был успешно обновлён.' }
      else
        format.html { render :edit }
      end
    end
  end

  def destroy
    @post.destroy
    respond_to do |format|
      format.html { redirect_to posts_url, notice: 'Пост был успешно удалён.' }
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_post
    @post = Post.find(params[:id])
  end

  # checking autorithations user or not
  def owner
    if @post.author_id == @current_user.id && @current_user.baned == false
    else
      respond_to do |format|
        format.html { redirect_to posts_url, alert: 'У вас нет прав, зарегестрируйтесь.' }
      end
    end
  end

  def post_params
    params.require(:post).permit(:title, :content, :author_id, :image)
  end
end

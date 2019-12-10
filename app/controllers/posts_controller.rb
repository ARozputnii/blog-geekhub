class PostsController < ApplicationController
  impressionist actions: [:show]
  before_action :require_login, only: %i[create edit update destroy]
  before_action :set_post, only: %i[show edit update destroy]
  before_action :owner, only: %i[edit update destroy]
  # GET /posts
  # GET /posts.json
  def index
    # seach in db with paginate
    if params[:search]
      @posts = Post.search(params[:search]).order(created_at: :desc).paginate(page: params[:page], per_page: 3)
    else
      @posts = Post.all.order(created_at: :desc).paginate(page: params[:page], per_page: 3)
    end
    @post = Post.first
    @author = current_user
  end

  def show
    #counter
    impressionist(@post)
  end

  # GET /posts/new
  def new
    if current_user
      @post = Post.new
    else
      redirect_to login_path
    end
  end
  # GET /posts/1/edit
  def edit
  end
  # POST /posts
  def create
    if @current_user.baned == false
    @post = current_user.posts.build(post_params)

      respond_to do |format|
        if @post.save
          format.html { redirect_to @post, notice: 'Пост был успешно создан.' }
          format.json { render :show, status: :created, location: @post }
        else
          format.html { render :new }
          format.json { render json: @post.errors, status: :unprocessable_entity }
        end
      end
    end
  end

  # PATCH/PUT /posts/1
  def update
    # If not a owner- you cant edit/destroy
    redirect_to root_path if owner == false

    respond_to do |format|
      if @post.update_attributes(post_params)
        format.html { redirect_to @post, notice: 'Пост был успешно обновлён.' }
        format.json { render :show, status: :ok, location: @post }
      else
        format.html { render :edit }
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end
  end
  # DELETE /posts/1
  def destroy
    @post.destroy

    respond_to do |format|
      format.html { redirect_to posts_url, notice: 'Пост был успешно удалён.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_post
      @post = Post.find(params[:id])
    end

        # checking autorithations user or not
  def owner
    if (@post.author_id == @current_user.id && @current_user.baned == false)
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

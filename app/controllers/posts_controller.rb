class PostsController < ApplicationController
  before_action :set_post, only: [:show, :edit, :update, :destroy]
  impressionist :actions=>[:show]
  # GET /posts
  # GET /posts.json
  def index
    # seach in db with paginate
    if params[:search]
      @posts = Post.search(params[:search]).order(created_at: :desc).paginate(page: params[:page], per_page: 3)
    else
      @posts = Post.all.order(created_at: :desc).paginate(page: params[:page], per_page: 3)
    end
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
      @post = current_user.posts.build(post_params)
      respond_to do |format|
        if @post.save
          format.html { redirect_to @post, notice: 'Post was successfully created.' }
          format.json { render :show, status: :created, location: @post }
        else
          format.html { render :new }
          format.json { render json: @post.errors, status: :unprocessable_entity }
        end
      end
  end

  # PATCH/PUT /posts/1
  def update
    if owner == false
      redirect_to root_path
    end
    respond_to do |format|
      if @post.update(post_params)
        format.html { redirect_to @post, notice: 'Post was successfully updated.' }
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
      format.html { redirect_to posts_url, notice: 'Post was successfully destroyed.' }
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
      if @post.author_id == @current_user.id
      else
        redirect_to login_path
      end
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def post_params
      params.require(:post).permit(:author_id, :title, :content, :image)
    end
end

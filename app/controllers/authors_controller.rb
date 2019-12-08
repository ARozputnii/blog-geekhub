class AuthorsController < ApplicationController
  before_action :set_author, only: %i[show edit update ]
  def index
    @author = Author.all
  end

  def new
    @author = Author.new
  end

  def create
    @author = Author.new(author_params)
      if @author.save
        AuthorMailer.with(author: @author).welcome_email.deliver_later
        redirect_to login_path, notice: 'Author was created! Now you can log in!'
      else
        render :new
      end
  end

  def edit
  end

  def update
    respond_to do |format|
      if @author.update(author_params)
        format.html { redirect_to @author, notice: 'User was successfully updated.' }
      else
        format.html { render :edit }
      end
    end
  end

  def show
  end

  private

  def set_author
    @author = Author.find(params[:id])
  end

  def author_params
    params.require(:author).permit(:email, :password, :password_confirmation, :first_name, :last_name, :gender, :birthday, :image)
  end
end
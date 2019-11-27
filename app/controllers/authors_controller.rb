class AuthorsController < ApplicationController
  
  def index
    @author = Author.all
  end

  def new
    @author = Author.new
  end

  def create
    @author = Author.new(author_params)
      if @author.save
          redirect_to login_path, notice: 'Author was created! Now you can log in!'
      else
        render :new
      end
  end

  def show
    @author = Author.find(params[:id])
  end


  def author_params
    params.require(:author).permit(:email, :password, :first_name, :last_name, :gender, :birthday)
  end
end
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
      # AuthorMailer.with(author: @author).welcome_email.deliver_later
      AuthorMailer.with(author: @author).registration_confirmation.deliver_later
      flash[:notice] = "Пожалуйста, подтвердите свой адрес электронной почты"
      redirect_to root_url
    else
      flash[:error] = "что-то пошло не так!"
      render 'new'
    end
  end

  def edit
  end

  def update
    respond_to do |format|
      if @author.update(author_params)
        format.html { redirect_to @author, notice: 'Пользователь был успешно обновлен.' }
      else
        format.html { render :edit }
      end
    end
  end

  def show
  end

  def confirm_email
    @author = Author.find_by_confirm_token(params[:id])
    if @author
      @author.email_activate
      flash[:success] = "Ваше сообщение было подтверждено.
       Пожалуйста, войдите, чтобы продолжить"
      redirect_to login_path
    else
      flash[:error] = "Пользователя не существует"
      redirect_to root_url
    end
  end

  private

  def set_author
    @author = Author.find(params[:id])
  end

  def author_params
    params.require(:author).permit(:email, :password, :password_confirmation, :first_name, :last_name, :gender, :birthday, :image)
  end

end
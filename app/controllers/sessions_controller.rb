class SessionsController < ApplicationController
  def new; end

  def create
    author = Author.find_by_email(params[:email])
    if author&.authenticate(params[:password])
      if author.email_confirmed
        session[:author_id] = author.id
        login_in(author)
        redirect_to root_path
      else
        flash.now[:alert] = 'Пожалуйста, активируйте свою учетную запись, следуя
         инструкции в электронном письме с подтверждением, которое вы получили, чтобы продолжить'
        render 'new'
      end
    else
      flash.now[:alert] = 'Неверная комбинация электронной почты или пароля' # Not quite right!
      render 'new'
    end
  end

  def destroy
    session[:author_id] = nil
    redirect_to root_path, notice: 'Досвидания!'
  end
end


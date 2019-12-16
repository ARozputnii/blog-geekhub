class PasswordResetsController < ApplicationController

  def create
    author = Author.find_by_email(params[:email])
    author.send_password_reset if author
    redirect_to root_url, :notice => "На Вашу почту было отправлено письмо с инструкцией."
  end

  def edit
    @author = Author.find_by_confirm_token!(params[:id])
  end

  def update
    @author = Author.find_by_confirm_token!(params[:id])
    if @author.password_reset_sent_at < 2.hours.ago
      redirect_to new_password_reset_path, :alert => "Срок действия сброса пароля истек, повторите процеду."
    elsif @author.update_attributes(params.require(:author).permit(:password, :password_confirmation))
      redirect_to root_url, :notice => "Пароль успешно изменён!"
    else
      render :edit
    end
  end

end
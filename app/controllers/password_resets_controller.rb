class PasswordResetsController < ApplicationController
  before_action :find_token, only: %i[edit update]

  def create
    author = Author.find_by_email(params[:email])
    author&.send_password_reset
    redirect_to root_url, notice: 'На Вашу почту было отправлено письмо с инструкцией.'
  end

  def edit; end

  def update
    if @author.password_reset_sent_at < 2.hours.ago
      redirect_to new_password_reset_path, alert: 'Срок действия сброса пароля истек, повторите процеду.'
    elsif @author.update_attributes(params.require(:author).permit(:password, :password_confirmation))
      redirect_to root_url, notice: 'Пароль успешно изменён!'
    else
      render :edit
    end
  end

  private

  def find_token
    @author = Author.find_by_confirm_token!(params[:id])
  end
end

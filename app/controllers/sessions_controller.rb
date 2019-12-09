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
        flash.now[:alert] = 'Please activate your account by following the
        instructions in the account confirmation email you received to proceed'
        render 'new'
      end
    else
      flash.now[:alert] = 'Invalid email/password combination' # Not quite right!
      render 'new'
    end
  end

  def destroy
    session[:author_id] = nil
    redirect_to root_path, notice: 'Logged out!'
  end
end


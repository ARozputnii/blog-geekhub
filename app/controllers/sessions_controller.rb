class SessionsController < ApplicationController
  def new; end

  def create

    author = Author.find_by_email(params[:email])
    if author&.authenticate(params[:password])
      session[:author_id] = author.id
      if author.email_confirmed
        sign_in
        redirect_back
      else
        flash.now[:error] = 'Please activate your account by following the
        instructions in the account confirmation email you received to proceed'
        render 'new'
      end
    else
      flash.now[:error] = 'Invalid email/password combination' # Not quite right!
      render 'new'
    end
  end

  def destroy
    session[:author_id] = nil
    redirect_to root_path, notice: 'Logged out!'
  end
end


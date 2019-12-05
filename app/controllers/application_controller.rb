class ApplicationController < ActionController::Base
  helper_method :current_user, :logged_in?
  before_action :unloged
  before_action :banned?


  def current_user
    if session[:author_id]
      @current_user ||= Author.find(session[:author_id])
    else
      @current_user = nil
    end
  end

  def require_login
    redirect_to login_path unless logged_in?

  end

  def login_in(author)
    session[:author_id] = author.id
  end

private

  def logged_in?
    !current_user.nil?
  end

  def unloged
    cookies[:actions] = if cookies[:actions]
                          cookies[:actions].to_i + 1
                        else
                          0
                        end
  end

  def banned?
    if current_user.present?
      if current_user.baned == true
        flash[:alert] = 'Your are not allowed to create comments or posts. (banned)'
      end
    end
  end
end
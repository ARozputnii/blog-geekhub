class AuthorMailer < ApplicationMailer
  default from: 'notifications@example.com'

  def welcome_email
    @user = params[:author]
    @url  = 'http://localhost:3000/signup'
    mail(to: @author.email, subject: 'Welcome to My Awesome Site')
  end
end

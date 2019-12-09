class AuthorMailer < ApplicationMailer
  default from: 'notifications@example.com'


  def welcome_email
    @author = params[:author]
    @url  = 'http://localhost:3000/signup'
    mail(to: @author.email, subject: 'Welcome to My Awesome Site')
  end

  def registration_confirmation
    @author = params[:author]
    @url = confirm_email_author_url(@author.confirm_token)
    mail(to: @author.email, subject: "Registration Confirmation")
  end

end

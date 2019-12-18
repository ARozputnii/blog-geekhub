class ApplicationMailer < ActionMailer::Base
  default from: 'a.rozputnii@gmail.com' # Замените этот адрес электронной почты своим собственным
  layout 'mailer'
end

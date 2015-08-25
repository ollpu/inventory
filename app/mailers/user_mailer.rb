class UserMailer < ApplicationMailer
  def send_password_token(user)
    @link = user.password_token_link
    mail(to: user.email)
  end
end

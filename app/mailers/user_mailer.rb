class UserMailer < ApplicationMailer
  def send_password_token(user)
    # @link =
    #   user_url user, { :token => user.password_reset_token }
    mail(to: user.email)
  end
end

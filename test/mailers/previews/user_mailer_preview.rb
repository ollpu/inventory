# Preview all emails at http://localhost:3000/rails/mailers/user_mailer
class UserMailerPreview < ActionMailer::Preview
  def send_password_token
    user = User.new
    user.password_reset_token = "test_token"
    user.password_reset_time = Time.now
    UserMailer.send_password_token(user)
  end
end

class User < ActiveRecord::Base
  
  attr_accessor :password, :password_confirmation
  before_save :encypt_password
  
  validates :password_confirmation,
    presence: true,
    on: :new
  validates :password,
    presence: true,
    confirmation: { :on => :create },
    on: :new
  validates :email,
    presence: true,
    format: { with: /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i, on: :create },
    uniqueness: { case_sensitive: false }
  
  def encypt_password
    if password.present?
      self.password_salt = BCrypt::Engine.generate_salt
      self.password_hash = BCrypt::Engine.hash_secret(password, password_salt)
    end
  end
  
  protected
    def after_create
      # Expire main trivia (includes User.count)
      expire_fragment 'main_trivia'
    end
    def after_destroy; after_create; end
end

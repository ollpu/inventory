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
  validates :privileges,
    presence: true,
    inclusion: { in: 0..2 }
  
  def encypt_password
    if password.present?
      self.password_salt = BCrypt::Engine.generate_salt
      self.password_hash = BCrypt::Engine.hash_secret(password, password_salt)
    end
  end
  
  # Authenicate using email and password. Returns user if successful or nil
  # if not.
  def self.authenticate email, password
    user = find_by_email email
    if user
      user if user.authenticate password
    end
  end
  
  # Authenticate using syntax user.authencticate password if user is
  # pre-determined. Returns true or false.
  def authenticate password
    hash = BCrypt::Engine.hash_secret password, password_salt
    hash == password_hash
  end
  
  
  # Permission levels
  def viewer?; privileges >= 0; end # Is atleast viewer
  def editor?; privileges >= 1; end # Is atleast editor
  def admin?;  privileges >= 2; end # Is atleast admin
  
  protected
    def after_create
      # Expire main trivia (includes User.count)
      expire_fragment 'main_trivia'
    end
    def after_destroy; after_create; end
end

class User < ActiveRecord::Base
  
  attr_accessor :password_confirmation, :old_password
  attr_reader :password
  def password= string
    @password = string
    @prev_password_hash = password_hash
    @prev_password_salt = password_salt
    encrypt_password
  end
  
  # password accessors for admin (sets @password_admin to true)
  def password_admin= string
    @password_admin = true
    password = string
  end
  def password_admin; password; end
  
  
  validates :password_confirmation,
    presence: true,
    if: "password.present?"
  validates :password,
    presence: true,
    confirmation: true,
    length: { minimum: 5 },
    if: "password.present?"
  
  validate :old_password_matching
  
  def old_password_matching
    if password.present? and not @password_admin and @prev_password_hash.present?
      old_password_hash = BCrypt::Engine.hash_secret(old_password, @prev_password_salt)
      unless old_password_hash == @prev_password_hash
        errors[:old_password] << I18n.t(:old_password_no_match, scope: [:errors])
      end
    end
  end
  
  validates :password_hash, presence: true
  validates :password_salt, presence: true
  
  validates :email,
    presence: true,
    format: { with: /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i },
    uniqueness: { case_sensitive: false }
  validates :privileges,
    presence: true,
    inclusion: { in: 0..2 }
  
  def encrypt_password
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
  
  PERMISSION_LEVELS = {
    0 => I18n.t(:viewer, scope: [:permission_levels]),
    1 => I18n.t(:editor, scope: [:permission_levels]),
    2 => I18n.t(:admin, scope: [:permission_levels]),
  }
  
  protected
    def after_create
      # Expire main trivia (includes User.count)
      expire_fragment 'main_trivia'
    end
    def after_destroy; after_create; end
end

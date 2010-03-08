class User < ActiveRecord::Base

  include Authorization::Entity

  has_many :role_assignments, :as => :entity
  has_many :roles, :through => :role_assignments

  validates_presence_of :username
  validates_uniqueness_of :username
  validates_presence_of :password,
    :on => :create
  validates_presence_of :password_confirmation,
    :if => Proc.new { |u| !u.password.blank? }
  attr_accessor :password_confirmation
  validates_confirmation_of :password,
    :message => "must match confirm password",
    :if => Proc.new { |u| !u.password.blank? }
  attr_accessor :current_password
  validate_on_update :current_password_correct?,
    :if => Proc.new { |u| !u.password.blank? }

  def title
    username
  end

  def password
    @password
  end

  def password=(pass)
    @password = pass
    return if pass.blank?
    salt = [Array.new(6){rand(256).chr}.join].pack("m").chomp
    self.password_salt, self.password_hash =
      salt, Digest::SHA256.hexdigest(pass + salt)
  end

  def self.authenticate(user_params)
    user = self.find_by_username(user_params[:username])
    if user.blank? ||
      Digest::SHA256.hexdigest(user_params[:password].to_s + user.password_salt) !=
        user.password_hash
      return nil
    end
    user
  end

  private

  def current_password_correct?
    if User.authenticate(:username => username, :password => current_password).nil?
      errors.add(:current_password, 'does not match your current password')
    end
  end
end

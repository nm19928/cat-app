require 'bcrypt'

class User < ApplicationRecord
  has_secure_password

  attr_reader :password

  validates :username, uniqueness: true
  validates :password_digest, presence: {message:"Password cannot be blank"}
  validates :password, length: {minimum: 6, allow_nil:true}
  validates :session_token, presence: true
  after_initialize :ensure

  has_many:cats,
  class_name: "Cats",
  primary_key: :id,
  foreign_key: :owner_id

  def password=(password)
    @password = password
    self.password_digest = BCrypt::Password.create(password)
  end

  def self.generate_session_token
    SecureRandom::urlsafe_base64(16)
  end

  def self.find_by_credentials(username,password)
    user = User.find_by(username:username)
    return nil if user.nil?
    user.authenticate(password) ? user:nil
  end

  def restart_token
    self.session_token = self.class.generate_session_token
    self.save!
    self.session_token
  end

  def owns_cat?(cat)
    cat.owner_id.to_i == self.id
  end

  def ensure
    self.session_token ||= self.class.generate_session_token
  end

end

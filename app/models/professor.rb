class Professor < ActiveRecord::Base
  attr_accessible :email, :f_name, :l_name, :password, :password_confirmation
  has_secure_password

  validates :f_name, presence: true, length: { maximum: 50 }
  validates :l_name, presence: true, length: { maximum: 50 }
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence: true, format: { with: VALID_EMAIL_REGEX }, uniqueness: { case_sensitive: false }
  validates :password, presence: true, length: { minimum:6 }
  validates :password_confirmation, presence: true

end

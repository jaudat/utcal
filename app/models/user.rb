class User < ActiveRecord::Base
  attr_accessible :utorid, :password, :password_confirmation, :type
  has_secure_password
  
  before_save { |user| user.utorid = utorid.downcase }
  
  validates :utorid, presence: true, length: { maximum: 50 }
  validates :password, presence: true, length: { minimum: 6 }
  validates :password_confirmation, presence: true

  has_one :student, :dependent => :destroy
  has_one :professor, :dependent => :destroy
  has_and_belongs_to_many :courses



  def mycourses
  	#gets list of courses of the user
    courses
  end

  def get_course
      courses
  end

end

class Student < ActiveRecord::Base
  attr_accessible :address, :email, :f_name, :l_name, :stud_no, :user_id

  validates :user_id, presence: true
  validates :f_name,  length: { maximum: 50 }
  validates :l_name,  length: { maximum: 50 }
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email,  format: { with: VALID_EMAIL_REGEX } 
  #, uniqueness: { case_sensitive: false }
  
  belongs_to :user

  def to_param
	user_id
  end
  #get the user model for this student
  def get_user
    self.user
  end



 
end

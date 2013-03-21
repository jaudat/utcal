class Professor < ActiveRecord::Base
  attr_accessible :email, :f_name, :l_name, :user_id
 
  validates :user_id, presence: true
  validates :f_name,  length: { maximum: 50 }
  validates :l_name,  length: { maximum: 50 }
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence: true, format: { with: VALID_EMAIL_REGEX }
  #, uniqueness: { case_sensitive: false }

   belongs_to :user

   def to_param
   	user_id
   end
end

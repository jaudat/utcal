class Assignments < ActiveRecord::Base

  attr_accessible :cid, :startdate 
  belongs_to :course

 	def get_courses
		course 
	end

end

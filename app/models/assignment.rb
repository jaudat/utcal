class Assignment < ActiveRecord::Base
  attr_accessible :description, :end, :start, :title, :category, :type
  has_one :courses
end

	def get_courses
		courses
	end

class Assignment < ActiveRecord::Base
  attr_accessible :description, :end, :start, :title, :category, :type
  has_one :courses
end

	def get_courses
		courses
	end


	public
	 def profassgns2(user_assgns)
	    @assgn_courses = user_assgns.mycourses
	    @assgn_courses.each do |a|
	      @get_assgns = a.get_assignments

	    end
	  end 



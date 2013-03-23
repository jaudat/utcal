class Course < ActiveRecord::Base
  attr_accessible :code, :days, :end, :location, :restrictions, :section, :start
  has_and_belongs_to_many :users


  def enrolledincourse
  	#get list of students in courses
  	users
  end

end

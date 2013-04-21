class Course < ActiveRecord::Base
  attr_accessible :code, :days, :end, :location, :restrictions, :section, :start
  has_and_belongs_to_many :users
  has_and_belongs_to_many :assignments


  def enrolledincourse
  	#get list of students in courses
  	users
  end
  #get all the assignments of the course
  def get_assignments
  	assignments
  end 
  def as_json(options = {})
  	{
  		:id => self.id,
  		:title => self.code,
  		:start => self.start,
  		:end => self.end,
  		:recurring => true,
  		:url => "http://www.rizvi.com/",
  		:semester => "Fall/Winter",
  		:type => "course"
  	}
  end

  def std_crs
    @std = []
    @users_temp = self.enrolledincourse
    @users_temp.each do |s|
      @get_std = s.student
      @std.push (@get_std)
    end 
    @std
  end

  def out_assgn
    @assgn = []
    @assgn_temp = self.get_assignments
    # @assgn_temp.each do |a|
    #   @get_std = s.student
    #   @std.push (@assgn)
    # end 
    @assgn_temp
  end

end

class Course < ActiveRecord::Base
  attr_accessible :code, :days, :end, :location, :restrictions, :section, :start, :meeting
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

  #get students of the course
  #this doesnt get users
  def std_crs
    @std = []
    @users_temp = self.enrolledincourse
    @users_temp.each do |s|
      @get_std = s.student
      if @get_std != nil
        @std.push (@get_std)
      end
    end 
    @std
  end

  #get all the assignments of this course
  def out_assgn
    @assgn = []
    @assgn_temp = self.get_assignments
    @assgn_temp
  end

  #get all the practicals and tutorials of
  #a course
  def getTutorials
    @course = self
    @tuts =Course.where("code = ? AND meeting LIKE ? OR meeting LIKE  ?",@course.code, "TUT%","PRAC%")
    @tuts
  end

end

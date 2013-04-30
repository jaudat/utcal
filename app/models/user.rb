class User < ActiveRecord::Base
  attr_accessible :utorid, :password, :password_confirmation, :category
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

  #for the users get all
  #the student courses
  def allstudcourses
    # Get professors courses
    @courses = self.mycourses

    @students = []
    @stud_courses = []
    # Get students who are taking the professors courses
    @courses.each do |course|
      @c = Course.find(course.id)
      @students = @c.enrolledincourse
    end
    

    #remove duplicate students from list
    dupes = []
    @students.each do |u|
      c = dupes.find_all {|e| e == u}.size
      dupes.push(u) unless c > 0
    end

    dupes.each do |student|
      # remove myself and my courses from list
      if student.id != self.id
        @stud_courses.push(student.mycourses)
      end
    end
    # Turn Nested array into an array of courses
    @sc = []
    @stud_courses.each do |sc1|
      sc1.each do |sc2|
        @sc.push(sc2)
      end
    end
    #remove duplicate courses and change course code
    @final = []
    @sc.each do |u|
      c = @final.find_all {|e| e == u}.size
      lgth = @sc.find_all {|e| e == u}.size
      x = u
      x.code = x.code + "#" + lgth.to_s()
      @final.push(x) unless c > 0
    end

    @final
  end

  def studcourses(course)

    @stud_courses = []
    @students = course.enrolledincourse

    # Get the courses that the students are taking
    @students.each do |student|
      @stud_courses.push(student.mycourses)
    end
    # Turn Nested array into an array of courses
    @sc = []
    @stud_courses.each do |sc1|
      sc1.each do |sc2|
        @sc.push(sc2)
      end
    end
    #remove duplicate courses and change course code
    @final = []
    @sc.each do |u|
      c = @final.find_all {|e| e == u}.size
      lgth = @sc.find_all {|e| e == u}.size
      x = u
      x.code = x.code + "#" + lgth.to_s()
      @final.push(x) unless c > 0
    end

    @final
  end  

end

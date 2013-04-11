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

  def allstudcourses
    # Get professors courses
    @courses = self.mycourses

    # puts "*****************************"
    # puts "printing list of courses of prof"
    # @courses.each do |sc1|
    #   puts sc1.code
    # end
    # puts "*****************************"

    @students = []
    @stud_courses = []
    # Get students who are taking the professors courses
    @courses.each do |course|
      @c = Course.find(course.id)
      @students = @c.enrolledincourse
    end
    
    # puts "*****************************"
    # puts "printing students who are in profs courses w dups"
    # @students.each do |sc1|
    #   puts sc1.id
    # end
    # puts "*****************************"

    #remove duplicate students from list
    dupes = []
    @students.each do |u|
      c = dupes.find_all {|e| e == u}.size
      dupes.push(u) unless c > 0
    end

   
    # puts "*****************************"
    # puts "printing students who are in profs courses w/o dups"
    # dupes.each do |sc1|
    #   puts sc1.id
    # end
    # puts "*****************************"

    # Get the courses that the students are taking
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

    #loop throught the course 
    # puts "*****************************"
    # puts "printing final courses"
    # @final.each do |sc1|
    #   print sc1.id
    #   puts sc1.code
    # end
    # puts "*****************************"
    @final
  end

  def studcourses(course)

    @stud_courses = []
    @students = course.enrolledincourse
    # puts "*************************************************"
    # @students.each do |student|
    #   puts student.id
    # end
    # puts "*************************************************"

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

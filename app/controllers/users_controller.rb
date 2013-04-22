class UsersController < ApplicationController

  def new
  	@user = User.new
  end

  def create
    @user = User.new(params[:user])
    @user2 = User.new(utorid: params[:user][:utorid], password: params[:user][:password], password_confirmation: params[:user][:password_confirmation])
    if @user2.save
      #TODO get user type then redirect to appropriate page
      if @user.type == "Student"
        @student = Student.new(user_id: @user2.id, f_name: @user2.utorid ,email: "my_email@utoronto.com")
        #url_for(:only_path => true, :controller => 'professor', :action => show, :id => @user.id)
        if @student.save
          sign_in @user2
          flash[:success] = "Welcome to UTCal"
          redirect_to @student
        else
          render 'new'
        end
      elsif @user.type == "Professor"
        @professor = Professor.new(user_id: @user2.id, f_name: @user2.utorid, email: "my_email@utoronto.com")
        #url_for(:only_path => true, :controller => 'professor', :action => show, :id => @user.id)
        if @professor.save
          sign_in @user2
          flash[:success] = "Welcome to UTCal"
          redirect_to @professor   
        else
          render 'new'
        end
      else
        render 'new'
      end
    else
      render 'new'
    end
  end

  def show
  end
  
  def mycourselist
    @courses = current_user.mycourses
    render 'mycourses'
  end

  def makeArray(arr)
      @temp_arr =[]
      arr.each do |arr1|
        arr1.each do |arr2|
          @temp_arr.push(arr2)
        end  
      end
      @temp_arr
  end

  def removeDupes(arr)
      #removing duplicate assignments
    @final = []
    @arr.each do |u|
        c = @final.find_all {|e| e == u}.size
        lgth = @arr.find_all {|e| e == u}.size
        x = u
        temp_id = x.id
        temp_id_str = temp_id.to_s
        temp_id_str = temp_id.to_s + "#" + lgth.to_s()
        temp_id = temp_id_str.to_i
        x.id = temp_id
         x.id = x.id + "#" + lgth.to_s()
        @final.push(x) unless c > 0
    end 

    @final


  end

  
  def mystudents_courses
    @courses = Course.find(params[:id])
    @crs_arr  = []
    @asgn_arr = []
    @std_arr = []

    @temp_students = @courses.std_crs
    @std_arr.push(@temp_students)
    @temp_students.each do |s|
      @user = s.get_user
      @temp_crs = @user.mycourses
      @crs_arr.push(@temp_crs)
      @temp_crs.each do |c|
        @asgn_arr.push(c.get_assignments)
      end


      @courses = makeArray(@crs_arr).uniq

      @assignments = makeArray(@asgn_arr).uniq

      @students =makeArray(@std_arr)
    end

    render 'students_courses'
    # bool = false
    # @crses = current_user.courses

    # @crses.each do |course|
    #   if course.id = @c.id
    #     bool = true
    #   end
    # end

    # if bool == true and session[:type] == "Professor"
    #   @courses = current_user.studcourses(@c)
    #   render 'students_courses'
    # end
  end

  def courseasgns
    # @asgns  = []
    @course = Course.find(params[:id])
    @asgns = @course.get_assignments
     render 'students_courses'

  end




end

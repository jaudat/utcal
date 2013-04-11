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
  
  def mystudents_courses
    @c = Course.find(params[:id])
    bool = false
    @crses = current_user.courses

    @crses.each do |course|
      if course.id = @c.id
        bool = true
      end
    end

    if bool == true and session[:type] == "Professor"
      @courses = current_user.studcourses(@c)
      render 'students_courses'
    end
  end


end
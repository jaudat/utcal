class ProfessorsController < ApplicationController
  before_filter :signed_in_user
  before_filter :correct_user
  # GET /professors
  # GET /professors.json

  def index
    @professors = Professor.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @professors }
    end
  end

  # GET /professors/1
  # GET /professors/1.json

  def removeDupes(arr)
      @temp_arr =[]
      arr.each do |arr1|
        arr1.each do |arr2|
          @temp_arr.push(arr2)
        end  
      end
      @temp_arr
  end

  def show


  
    @professor = Professor.find_by_user_id(params[:id])
      @courses = current_user.mycourses
      @temp_tutorials = []
      @temp_students = []
      @temp_assignments = []
      @courses.each do |c|
        @temp_students.push(c.std_crs)
        @temp_tutorials.push(c.getTutorials)
        @temp_assignments.push(c.get_assignments)
      end
      @students = removeDupes(@temp_students)
      @assignments = removeDupes(@temp_assignments)
      @tutorials = removeDupes(@temp_tutorials)

      #get all tutorials and practicals
      

      respond_to do |format|
        format.html # show.html.erb
        format.json { render :json => {:professor => @professor, :courses => @courses,
                                       :tutorials => @tutorials}}
      
      end
   
  end

  # GET /professors/new
  # GET /professors/new.json
  def new
    @professor = Professor.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @professor }
    end


  end

  # GET /professors/1/edit
  def edit
    @professor = Professor.find_by_user_id(params[:id])
  end

  # POST /professors
  # POST /professors.json
  def create
    @professor = Professor.new(params[:professor])

    respond_to do |format|
      if @professor.save
        format.html { redirect_to @professor, notice: 'Professor was successfully created.' }
        format.json { render json: @professor, status: :created, location: @professor }
      else
        format.html { render action: "new" }
        format.json { render json: @professor.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /professors/1
  # PUT /professors/1.json
  def update
    @professor = Professor.find_by_user_id(params[:id])

    respond_to do |format|
      if @professor.update_attributes(params[:professor])
        format.html { redirect_to @professor, notice: 'Professor was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @professor.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /professors/1
  # DELETE /professors/1.json
  def destroy
    @professor = Professor.find_by_user_id(params[:id])
    @professor.destroy

    respond_to do |format|
      format.html { redirect_to professors_url }
      format.json { head :no_content }
    end
  end

  def add_students
    @professor = Professor.find_by_user_id(params[:id])

    respond_to do |format|
      format.html
      format.json { render json: @professor }
    end
  end

  def mail_students
    @professor = Professor.find_by_user_id(params[:id])
    @all_emails = params[:emadds]

    respond_to do |format|
      email = @all_emails.split(",").map(&:strip).reject(&:empty?)

      student_mailer.sign_to_courses(@professor, email).deliver
      format.html
      format.json {render json: @professor}
   end 

  end




  private
    def signed_in_user
      redirect_to signin_url, notice: "Please sign in" unless signed_in?
    end
    def correct_user
      @user = User.find(params[:id])
      redirect_to(root_path) unless current_user?(@user)
    end



end

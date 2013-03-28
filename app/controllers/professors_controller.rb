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
  def show
   @professor = Professor.find_by_user_id(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @professor }
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

  def display
    @professors = Professor.find_by_user_id(params[:id])
    respond_to do |format|
        format.html
	format.json { render json: @professor }
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

class AssgnControllerController < ApplicationController


  def show
    @assgn = Assignments.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @assgn }
    end
  end


end

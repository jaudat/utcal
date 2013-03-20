class UsersController < ApplicationController
  def new
  	@user = User.new
  end


  def create
    @user = User.new(params[:user])
    if @user.save
      #TODO get user type then redirect to appropriate page
      #if @user.type == "Professor"
      #  @professor = Professor.create(user_id: @user.id)
        #url_for(:only_path => true, :controller => 'professor', :action => show, :id => @user.id)
        redirect_to(@user)
      end
    else
      render 'new'
    end

  end
end
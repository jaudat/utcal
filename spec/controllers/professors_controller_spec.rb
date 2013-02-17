require 'spec_helper'

# This spec was generated by rspec-rails when you ran the scaffold generator.
# It demonstrates how one might use RSpec to specify the controller code that
# was generated by Rails when you ran the scaffold generator.
#
# It assumes that the implementation code is generated by the rails scaffold
# generator.  If you are using any extension libraries to generate different
# controller code, this generated spec may or may not pass.
#
# It only uses APIs available in rails and/or rspec-rails.  There are a number
# of tools you can use to make these specs even more expressive, but we're
# sticking to rails and rspec-rails APIs to keep things simple and stable.
#
# Compared to earlier versions of this generator, there is very limited use of
# stubs and message expectations in this spec.  Stubs are only used when there
# is no simpler way to get a handle on the object needed for the example.
# Message expectations are only used when there is no simpler way to specify
# that an instance is receiving a specific message.

describe ProfessorsController do

  # This should return the minimal set of attributes required to create a valid
  # Professor. As you add validations to Professor, be sure to
  # update the return value of this method accordingly.
  def valid_attributes
    { "f_name" => "MyString" }
  end

  # This should return the minimal set of values that should be in the session
  # in order to pass any filters (e.g. authentication) defined in
  # ProfessorsController. Be sure to keep this updated too.
  def valid_session
    {}
  end

  describe "GET index" do
    it "assigns all professors as @professors" do
      professor = Professor.create! valid_attributes
      get :index, {}, valid_session
      assigns(:professors).should eq([professor])
    end
  end

  describe "GET show" do
    it "assigns the requested professor as @professor" do
      professor = Professor.create! valid_attributes
      get :show, {:id => professor.to_param}, valid_session
      assigns(:professor).should eq(professor)
    end
  end

  describe "GET new" do
    it "assigns a new professor as @professor" do
      get :new, {}, valid_session
      assigns(:professor).should be_a_new(Professor)
    end
  end

  describe "GET edit" do
    it "assigns the requested professor as @professor" do
      professor = Professor.create! valid_attributes
      get :edit, {:id => professor.to_param}, valid_session
      assigns(:professor).should eq(professor)
    end
  end

  describe "POST create" do
    describe "with valid params" do
      it "creates a new Professor" do
        expect {
          post :create, {:professor => valid_attributes}, valid_session
        }.to change(Professor, :count).by(1)
      end

      it "assigns a newly created professor as @professor" do
        post :create, {:professor => valid_attributes}, valid_session
        assigns(:professor).should be_a(Professor)
        assigns(:professor).should be_persisted
      end

      it "redirects to the created professor" do
        post :create, {:professor => valid_attributes}, valid_session
        response.should redirect_to(Professor.last)
      end
    end

    describe "with invalid params" do
      it "assigns a newly created but unsaved professor as @professor" do
        # Trigger the behavior that occurs when invalid params are submitted
        Professor.any_instance.stub(:save).and_return(false)
        post :create, {:professor => { "f_name" => "invalid value" }}, valid_session
        assigns(:professor).should be_a_new(Professor)
      end

      it "re-renders the 'new' template" do
        # Trigger the behavior that occurs when invalid params are submitted
        Professor.any_instance.stub(:save).and_return(false)
        post :create, {:professor => { "f_name" => "invalid value" }}, valid_session
        response.should render_template("new")
      end
    end
  end

  describe "PUT update" do
    describe "with valid params" do
      it "updates the requested professor" do
        professor = Professor.create! valid_attributes
        # Assuming there are no other professors in the database, this
        # specifies that the Professor created on the previous line
        # receives the :update_attributes message with whatever params are
        # submitted in the request.
        Professor.any_instance.should_receive(:update_attributes).with({ "f_name" => "MyString" })
        put :update, {:id => professor.to_param, :professor => { "f_name" => "MyString" }}, valid_session
      end

      it "assigns the requested professor as @professor" do
        professor = Professor.create! valid_attributes
        put :update, {:id => professor.to_param, :professor => valid_attributes}, valid_session
        assigns(:professor).should eq(professor)
      end

      it "redirects to the professor" do
        professor = Professor.create! valid_attributes
        put :update, {:id => professor.to_param, :professor => valid_attributes}, valid_session
        response.should redirect_to(professor)
      end
    end

    describe "with invalid params" do
      it "assigns the professor as @professor" do
        professor = Professor.create! valid_attributes
        # Trigger the behavior that occurs when invalid params are submitted
        Professor.any_instance.stub(:save).and_return(false)
        put :update, {:id => professor.to_param, :professor => { "f_name" => "invalid value" }}, valid_session
        assigns(:professor).should eq(professor)
      end

      it "re-renders the 'edit' template" do
        professor = Professor.create! valid_attributes
        # Trigger the behavior that occurs when invalid params are submitted
        Professor.any_instance.stub(:save).and_return(false)
        put :update, {:id => professor.to_param, :professor => { "f_name" => "invalid value" }}, valid_session
        response.should render_template("edit")
      end
    end
  end

  describe "DELETE destroy" do
    it "destroys the requested professor" do
      professor = Professor.create! valid_attributes
      expect {
        delete :destroy, {:id => professor.to_param}, valid_session
      }.to change(Professor, :count).by(-1)
    end

    it "redirects to the professors list" do
      professor = Professor.create! valid_attributes
      delete :destroy, {:id => professor.to_param}, valid_session
      response.should redirect_to(professors_url)
    end
  end

end

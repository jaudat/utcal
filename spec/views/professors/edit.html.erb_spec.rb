require 'spec_helper'

describe "professors/edit" do
  before(:each) do
    @professor = assign(:professor, stub_model(Professor,
      :f_name => "MyString",
      :l_name => "MyString",
      :email => "MyString",
      :password => "MyString"
    ))
  end

  it "renders the edit professor form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => professors_path(@professor), :method => "post" do
      assert_select "input#professor_f_name", :name => "professor[f_name]"
      assert_select "input#professor_l_name", :name => "professor[l_name]"
      assert_select "input#professor_email", :name => "professor[email]"
      assert_select "input#professor_password", :name => "professor[password]"
    end
  end
end

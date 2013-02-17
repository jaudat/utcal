require 'spec_helper'

describe "students/show" do
  before(:each) do
    @student = assign(:student, stub_model(Student,
      :stud_no => "",
      :f_name => "F Name",
      :l_name => "L Name",
      :address => "MyText",
      :email => "Email"
    ))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(//)
    rendered.should match(/F Name/)
    rendered.should match(/L Name/)
    rendered.should match(/MyText/)
    rendered.should match(/Email/)
  end
end

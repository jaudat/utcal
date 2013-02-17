require 'spec_helper'

describe "students/new" do
  before(:each) do
    assign(:student, stub_model(Student,
      :stud_no => "",
      :f_name => "MyString",
      :l_name => "MyString",
      :address => "MyText",
      :email => "MyString"
    ).as_new_record)
  end

  it "renders new student form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => students_path, :method => "post" do
      assert_select "input#student_stud_no", :name => "student[stud_no]"
      assert_select "input#student_f_name", :name => "student[f_name]"
      assert_select "input#student_l_name", :name => "student[l_name]"
      assert_select "textarea#student_address", :name => "student[address]"
      assert_select "input#student_email", :name => "student[email]"
    end
  end
end

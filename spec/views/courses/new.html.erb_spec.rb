require 'spec_helper'

describe "courses/new" do
  before(:each) do
    assign(:course, stub_model(Course,
      :code => "MyString",
      :section => "MyString",
      :restrictions => "MyString",
      :days => "MyString",
      :location => "MyString"
    ).as_new_record)
  end

  it "renders new course form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => courses_path, :method => "post" do
      assert_select "input#course_code", :name => "course[code]"
      assert_select "input#course_section", :name => "course[section]"
      assert_select "input#course_restrictions", :name => "course[restrictions]"
      assert_select "input#course_days", :name => "course[days]"
      assert_select "input#course_location", :name => "course[location]"
    end
  end
end

require 'spec_helper'

describe "courses/edit" do
  before(:each) do
    @course = assign(:course, stub_model(Course,
      :code => "MyString",
      :section => "MyString",
      :restrictions => "MyString",
      :days => "MyString",
      :location => "MyString"
    ))
  end

  it "renders the edit course form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => courses_path(@course), :method => "post" do
      assert_select "input#course_code", :name => "course[code]"
      assert_select "input#course_section", :name => "course[section]"
      assert_select "input#course_restrictions", :name => "course[restrictions]"
      assert_select "input#course_days", :name => "course[days]"
      assert_select "input#course_location", :name => "course[location]"
    end
  end
end

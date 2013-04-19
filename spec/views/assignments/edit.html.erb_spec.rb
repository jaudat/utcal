require 'spec_helper'

describe "assignments/edit" do
  before(:each) do
    @assignment = assign(:assignment, stub_model(Assignment,
      :title => "MyString",
      :type => "",
      :description => "MyText"
    ))
  end

  it "renders the edit assignment form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form[action=?][method=?]", assignment_path(@assignment), "post" do
      assert_select "input#assignment_title[name=?]", "assignment[title]"
      assert_select "input#assignment_type[name=?]", "assignment[type]"
      assert_select "textarea#assignment_description[name=?]", "assignment[description]"
    end
  end
end

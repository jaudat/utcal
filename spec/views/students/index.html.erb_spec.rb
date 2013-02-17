require 'spec_helper'

describe "students/index" do
  before(:each) do
    assign(:students, [
      stub_model(Student,
        :stud_no => "",
        :f_name => "F Name",
        :l_name => "L Name",
        :address => "MyText",
        :email => "Email"
      ),
      stub_model(Student,
        :stud_no => "",
        :f_name => "F Name",
        :l_name => "L Name",
        :address => "MyText",
        :email => "Email"
      )
    ])
  end

  it "renders a list of students" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "".to_s, :count => 2
    assert_select "tr>td", :text => "F Name".to_s, :count => 2
    assert_select "tr>td", :text => "L Name".to_s, :count => 2
    assert_select "tr>td", :text => "MyText".to_s, :count => 2
    assert_select "tr>td", :text => "Email".to_s, :count => 2
  end
end

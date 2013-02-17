require 'spec_helper'

describe "courses/index" do
  before(:each) do
    assign(:courses, [
      stub_model(Course,
        :code => "Code",
        :section => "Section",
        :restrictions => "Restrictions",
        :days => "Days",
        :location => "Location"
      ),
      stub_model(Course,
        :code => "Code",
        :section => "Section",
        :restrictions => "Restrictions",
        :days => "Days",
        :location => "Location"
      )
    ])
  end

  it "renders a list of courses" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "Code".to_s, :count => 2
    assert_select "tr>td", :text => "Section".to_s, :count => 2
    assert_select "tr>td", :text => "Restrictions".to_s, :count => 2
    assert_select "tr>td", :text => "Days".to_s, :count => 2
    assert_select "tr>td", :text => "Location".to_s, :count => 2
  end
end

require 'spec_helper'

describe "courses/show" do
  before(:each) do
    @course = assign(:course, stub_model(Course,
      :code => "Code",
      :section => "Section",
      :restrictions => "Restrictions",
      :days => "Days",
      :location => "Location"
    ))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/Code/)
    rendered.should match(/Section/)
    rendered.should match(/Restrictions/)
    rendered.should match(/Days/)
    rendered.should match(/Location/)
  end
end

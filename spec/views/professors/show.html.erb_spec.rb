require 'spec_helper'

describe "professors/show" do
  before(:each) do
    @professor = assign(:professor, stub_model(Professor,
      :f_name => "F Name",
      :l_name => "L Name",
      :email => "Email",
      :password => "Password"
    ))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/F Name/)
    rendered.should match(/L Name/)
    rendered.should match(/Email/)
    rendered.should match(/Password/)
  end
end

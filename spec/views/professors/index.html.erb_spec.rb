require 'spec_helper'

describe "professors/index" do
  before(:each) do
    assign(:professors, [
      stub_model(Professor,
        :f_name => "F Name",
        :l_name => "L Name",
        :email => "Email",
        :password => "Password"
      ),
      stub_model(Professor,
        :f_name => "F Name",
        :l_name => "L Name",
        :email => "Email",
        :password => "Password"
      )
    ])
  end

  it "renders a list of professors" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "F Name".to_s, :count => 2
    assert_select "tr>td", :text => "L Name".to_s, :count => 2
    assert_select "tr>td", :text => "Email".to_s, :count => 2
    assert_select "tr>td", :text => "Password".to_s, :count => 2
  end
end

require 'spec_helper'

describe "pagoacreditos/index.html.erb" do
  before(:each) do
    assign(:pagoacreditos, [
      stub_model(Pagoacredito,
        :cantidad => 1
      ),
      stub_model(Pagoacredito,
        :cantidad => 1
      )
    ])
  end

  it "renders a list of pagoacreditos" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => 1.to_s, :count => 2
  end
end

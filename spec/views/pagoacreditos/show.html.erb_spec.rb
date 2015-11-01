require 'spec_helper'

describe "pagoacreditos/show.html.erb" do
  before(:each) do
    @pagoacredito = assign(:pagoacredito, stub_model(Pagoacredito,
      :cantidad => 1
    ))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/1/)
  end
end

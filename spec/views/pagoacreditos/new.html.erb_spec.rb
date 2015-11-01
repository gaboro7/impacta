require 'spec_helper'

describe "pagoacreditos/new.html.erb" do
  before(:each) do
    assign(:pagoacredito, stub_model(Pagoacredito,
      :cantidad => 1
    ).as_new_record)
  end

  it "renders new pagoacredito form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => pagoacreditos_path, :method => "post" do
      assert_select "input#pagoacredito_cantidad", :name => "pagoacredito[cantidad]"
    end
  end
end

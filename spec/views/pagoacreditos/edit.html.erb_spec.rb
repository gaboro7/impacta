require 'spec_helper'

describe "pagoacreditos/edit.html.erb" do
  before(:each) do
    @pagoacredito = assign(:pagoacredito, stub_model(Pagoacredito,
      :cantidad => 1
    ))
  end

  it "renders the edit pagoacredito form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => pagoacreditos_path(@pagoacredito), :method => "post" do
      assert_select "input#pagoacredito_cantidad", :name => "pagoacredito[cantidad]"
    end
  end
end

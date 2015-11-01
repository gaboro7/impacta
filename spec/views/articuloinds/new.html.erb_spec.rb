require 'spec_helper'

describe "articuloinds/new.html.erb" do
  before(:each) do
    assign(:articuloind, stub_model(Articuloind).as_new_record)
  end

  it "renders new articuloind form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => articuloinds_path, :method => "post" do
    end
  end
end

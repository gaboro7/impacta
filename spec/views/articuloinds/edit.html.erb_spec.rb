require 'spec_helper'

describe "articuloinds/edit.html.erb" do
  before(:each) do
    @articuloind = assign(:articuloind, stub_model(Articuloind))
  end

  it "renders the edit articuloind form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => articuloinds_path(@articuloind), :method => "post" do
    end
  end
end

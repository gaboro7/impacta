require 'spec_helper'

describe "articulocomps/edit.html.erb" do
  before(:each) do
    @articulocomp = assign(:articulocomp, stub_model(Articulocomp))
  end

  it "renders the edit articulocomp form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => articulocomps_path(@articulocomp), :method => "post" do
    end
  end
end

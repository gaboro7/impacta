require 'spec_helper'

describe "articulocomps/new.html.erb" do
  before(:each) do
    assign(:articulocomp, stub_model(Articulocomp).as_new_record)
  end

  it "renders new articulocomp form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => articulocomps_path, :method => "post" do
    end
  end
end

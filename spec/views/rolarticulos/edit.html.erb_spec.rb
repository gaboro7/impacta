require 'spec_helper'

describe "rolarticulos/edit.html.erb" do
  before(:each) do
    @rolarticulo = assign(:rolarticulo, stub_model(Rolarticulo))
  end

  it "renders the edit rolarticulo form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => rolarticulos_path(@rolarticulo), :method => "post" do
    end
  end
end

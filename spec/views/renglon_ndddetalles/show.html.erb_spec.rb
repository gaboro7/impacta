require 'spec_helper'

describe "renglon_ndddetalles/show.html.erb" do
  before(:each) do
    @renglon_ndddetalle = assign(:renglon_ndddetalle, stub_model(RenglonNdddetalle,
      :detalle => "Detalle",
      :notadedebito => nil,
      :total_impuestos => 1.5,
      :total_renglon => 1.5
    ))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/Detalle/)
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(//)
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/1.5/)
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/1.5/)
  end
end

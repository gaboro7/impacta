require 'spec_helper'

describe "renglon_nddndcs/show.html.erb" do
  before(:each) do
    @renglon_nddndc = assign(:renglon_nddndc, stub_model(RenglonNddndc,
      :notadecredito => nil,
      :notadedebito => nil,
      :detalle => "Detalle",
      :total_renglon => 1.5,
      :total_impuestos => 1.5
    ))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(//)
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(//)
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/Detalle/)
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/1.5/)
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/1.5/)
  end
end

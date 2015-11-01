require 'spec_helper'

describe "renglon_ndcdetalles/show.html.erb" do
  before(:each) do
    @renglon_ndcdetalle = assign(:renglon_ndcdetalle, stub_model(RenglonNdcdetalle,
      :detalle => "Detalle",
      :notadecredito => nil,
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

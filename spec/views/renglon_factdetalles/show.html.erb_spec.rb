require 'spec_helper'

describe "renglon_factdetalles/show.html.erb" do
  before(:each) do
    @renglon_factdetalle = assign(:renglon_factdetalle, stub_model(RenglonFactdetalle,
      :factura_id => "",
      :detalle => "Detalle",
      :subtotal_linea => 1.5,
      :impuestos => 1.5,
      :total_linea => 1.5
    ))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(//)
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/Detalle/)
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/1.5/)
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/1.5/)
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/1.5/)
  end
end

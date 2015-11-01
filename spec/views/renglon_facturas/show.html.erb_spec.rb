require 'spec_helper'

describe "renglon_facturas/show.html.erb" do
  before(:each) do
    @renglon_factura = assign(:renglon_factura, stub_model(RenglonFactura,
      :numero_factura => 1,
      :numero_renglon => 1,
      :detalle => "Detalle",
      :total_renglon => 1.5,
      :total_impuestos => 1.5
    ))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/1/)
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/1/)
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/Detalle/)
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/1.5/)
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/1.5/)
  end
end

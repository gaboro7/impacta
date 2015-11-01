require 'spec_helper'

describe "facturas/show.html.erb" do
  before(:each) do
    @factura = assign(:factura, stub_model(Factura,
      :numero => 1,
      :cliente_id => 1,
      :rut => "Rut",
      :direccion_cliente => "Direccion Cliente",
      :confirmada => false,
      :contabilizada => false,
      :anulada => false,
      :detalle => "Detalle",
      :total_n_gravado => 1.5,
      :total_gravado => 1.5,
      :total_impuestos => 1.5,
      :total_final => 1.5,
      :codigo_barras => "Codigo Barras"
    ))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/1/)
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/1/)
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/Rut/)
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/Direccion Cliente/)
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/false/)
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/false/)
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/false/)
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/Detalle/)
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/1.5/)
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/1.5/)
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/1.5/)
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/1.5/)
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/Codigo Barras/)
  end
end

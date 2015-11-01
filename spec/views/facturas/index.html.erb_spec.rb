require 'spec_helper'

describe "facturas/index.html.erb" do
  before(:each) do
    assign(:facturas, [
      stub_model(Factura,
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
      ),
      stub_model(Factura,
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
      )
    ])
  end

  it "renders a list of facturas" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => 1.to_s, :count => 2
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => 1.to_s, :count => 2
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "Rut".to_s, :count => 2
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "Direccion Cliente".to_s, :count => 2
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => false.to_s, :count => 2
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => false.to_s, :count => 2
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => false.to_s, :count => 2
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "Detalle".to_s, :count => 2
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => 1.5.to_s, :count => 2
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => 1.5.to_s, :count => 2
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => 1.5.to_s, :count => 2
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => 1.5.to_s, :count => 2
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "Codigo Barras".to_s, :count => 2
  end
end

require 'spec_helper'

describe "facturas/edit.html.erb" do
  before(:each) do
    @factura = assign(:factura, stub_model(Factura,
      :numero => 1,
      :cliente_id => 1,
      :rut => "MyString",
      :direccion_cliente => "MyString",
      :confirmada => false,
      :contabilizada => false,
      :anulada => false,
      :detalle => "MyString",
      :total_n_gravado => 1.5,
      :total_gravado => 1.5,
      :total_impuestos => 1.5,
      :total_final => 1.5,
      :codigo_barras => "MyString"
    ))
  end

  it "renders the edit factura form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => facturas_path(@factura), :method => "post" do
      assert_select "input#factura_numero", :name => "factura[numero]"
      assert_select "input#factura_cliente_id", :name => "factura[cliente_id]"
      assert_select "input#factura_rut", :name => "factura[rut]"
      assert_select "input#factura_direccion_cliente", :name => "factura[direccion_cliente]"
      assert_select "input#factura_confirmada", :name => "factura[confirmada]"
      assert_select "input#factura_contabilizada", :name => "factura[contabilizada]"
      assert_select "input#factura_anulada", :name => "factura[anulada]"
      assert_select "input#factura_detalle", :name => "factura[detalle]"
      assert_select "input#factura_total_n_gravado", :name => "factura[total_n_gravado]"
      assert_select "input#factura_total_gravado", :name => "factura[total_gravado]"
      assert_select "input#factura_total_impuestos", :name => "factura[total_impuestos]"
      assert_select "input#factura_total_final", :name => "factura[total_final]"
      assert_select "input#factura_codigo_barras", :name => "factura[codigo_barras]"
    end
  end
end

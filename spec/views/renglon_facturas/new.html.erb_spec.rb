require 'spec_helper'

describe "renglon_facturas/new.html.erb" do
  before(:each) do
    assign(:renglon_factura, stub_model(RenglonFactura,
      :numero_factura => 1,
      :numero_renglon => 1,
      :detalle => "MyString",
      :total_renglon => 1.5,
      :total_impuestos => 1.5
    ).as_new_record)
  end

  it "renders new renglon_factura form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => renglon_facturas_path, :method => "post" do
      assert_select "input#renglon_factura_numero_factura", :name => "renglon_factura[numero_factura]"
      assert_select "input#renglon_factura_numero_renglon", :name => "renglon_factura[numero_renglon]"
      assert_select "input#renglon_factura_detalle", :name => "renglon_factura[detalle]"
      assert_select "input#renglon_factura_total_renglon", :name => "renglon_factura[total_renglon]"
      assert_select "input#renglon_factura_total_impuestos", :name => "renglon_factura[total_impuestos]"
    end
  end
end

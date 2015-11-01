require 'spec_helper'

describe "renglon_notacreditos/new.html.erb" do
  before(:each) do
    assign(:renglon_notacredito, stub_model(RenglonNotacredito,
      :notadecredito => nil,
      :factura => nil,
      :comentario => "MyString",
      :cantidad => 1,
      :comercializable => nil,
      :descuento => 1.5,
      :precio_unitario => 1.5,
      :total_impuestos => 1.5,
      :total_renglon => 1.5
    ).as_new_record)
  end

  it "renders new renglon_notacredito form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => renglon_notacreditos_path, :method => "post" do
      assert_select "input#renglon_notacredito_notadecredito", :name => "renglon_notacredito[notadecredito]"
      assert_select "input#renglon_notacredito_factura", :name => "renglon_notacredito[factura]"
      assert_select "input#renglon_notacredito_comentario", :name => "renglon_notacredito[comentario]"
      assert_select "input#renglon_notacredito_cantidad", :name => "renglon_notacredito[cantidad]"
      assert_select "input#renglon_notacredito_comercializable", :name => "renglon_notacredito[comercializable]"
      assert_select "input#renglon_notacredito_descuento", :name => "renglon_notacredito[descuento]"
      assert_select "input#renglon_notacredito_precio_unitario", :name => "renglon_notacredito[precio_unitario]"
      assert_select "input#renglon_notacredito_total_impuestos", :name => "renglon_notacredito[total_impuestos]"
      assert_select "input#renglon_notacredito_total_renglon", :name => "renglon_notacredito[total_renglon]"
    end
  end
end

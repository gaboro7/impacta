require 'spec_helper'

describe "renglon_notadebitos/edit.html.erb" do
  before(:each) do
    @renglon_notadebito = assign(:renglon_notadebito, stub_model(RenglonNotadebito,
      :notadedebito => nil,
      :factura => nil,
      :comentario => "MyString",
      :cantidad => 1,
      :comercializable => nil,
      :descuento => 1.5,
      :precio_unitario => 1.5,
      :total_impuestos => 1.5,
      :total_renglon => 1.5
    ))
  end

  it "renders the edit renglon_notadebito form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => renglon_notadebitos_path(@renglon_notadebito), :method => "post" do
      assert_select "input#renglon_notadebito_notadedebito", :name => "renglon_notadebito[notadedebito]"
      assert_select "input#renglon_notadebito_factura", :name => "renglon_notadebito[factura]"
      assert_select "input#renglon_notadebito_comentario", :name => "renglon_notadebito[comentario]"
      assert_select "input#renglon_notadebito_cantidad", :name => "renglon_notadebito[cantidad]"
      assert_select "input#renglon_notadebito_comercializable", :name => "renglon_notadebito[comercializable]"
      assert_select "input#renglon_notadebito_descuento", :name => "renglon_notadebito[descuento]"
      assert_select "input#renglon_notadebito_precio_unitario", :name => "renglon_notadebito[precio_unitario]"
      assert_select "input#renglon_notadebito_total_impuestos", :name => "renglon_notadebito[total_impuestos]"
      assert_select "input#renglon_notadebito_total_renglon", :name => "renglon_notadebito[total_renglon]"
    end
  end
end

require 'spec_helper'

describe "descuento_clientes/edit" do
  before(:each) do
    @descuento_cliente = assign(:descuento_cliente, stub_model(DescuentoCliente,
      :cliente => nil,
      :comercializable => nil,
      :descuento => 1.5
    ))
  end

  it "renders the edit descuento_cliente form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => descuento_clientes_path(@descuento_cliente), :method => "post" do
      assert_select "input#descuento_cliente_cliente", :name => "descuento_cliente[cliente]"
      assert_select "input#descuento_cliente_comercializable", :name => "descuento_cliente[comercializable]"
      assert_select "input#descuento_cliente_descuento", :name => "descuento_cliente[descuento]"
    end
  end
end

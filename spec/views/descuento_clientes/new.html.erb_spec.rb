require 'spec_helper'

describe "descuento_clientes/new" do
  before(:each) do
    assign(:descuento_cliente, stub_model(DescuentoCliente,
      :cliente => nil,
      :comercializable => nil,
      :descuento => 1.5
    ).as_new_record)
  end

  it "renders new descuento_cliente form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => descuento_clientes_path, :method => "post" do
      assert_select "input#descuento_cliente_cliente", :name => "descuento_cliente[cliente]"
      assert_select "input#descuento_cliente_comercializable", :name => "descuento_cliente[comercializable]"
      assert_select "input#descuento_cliente_descuento", :name => "descuento_cliente[descuento]"
    end
  end
end

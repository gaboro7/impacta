require 'spec_helper'

describe "descuento_clientes/show" do
  before(:each) do
    @descuento_cliente = assign(:descuento_cliente, stub_model(DescuentoCliente,
      :cliente => nil,
      :comercializable => nil,
      :descuento => 1.5
    ))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(//)
    rendered.should match(//)
    rendered.should match(/1.5/)
  end
end

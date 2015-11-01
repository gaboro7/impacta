require 'spec_helper'

describe "descuento_clientes/index" do
  before(:each) do
    assign(:descuento_clientes, [
      stub_model(DescuentoCliente,
        :cliente => nil,
        :comercializable => nil,
        :descuento => 1.5
      ),
      stub_model(DescuentoCliente,
        :cliente => nil,
        :comercializable => nil,
        :descuento => 1.5
      )
    ])
  end

  it "renders a list of descuento_clientes" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => nil.to_s, :count => 2
    assert_select "tr>td", :text => nil.to_s, :count => 2
    assert_select "tr>td", :text => 1.5.to_s, :count => 2
  end
end

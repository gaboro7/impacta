require 'spec_helper'

describe "recibos/index.html.erb" do
  before(:each) do
    assign(:recibos, [
      stub_model(Recibo,
        :codigo_barras => "Codigo Barras",
        :contabilizado => false,
        :factura => "",
        :pagocontado => ""
      ),
      stub_model(Recibo,
        :codigo_barras => "Codigo Barras",
        :contabilizado => false,
        :factura => "",
        :pagocontado => ""
      )
    ])
  end

  it "renders a list of recibos" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "Codigo Barras".to_s, :count => 2
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => false.to_s, :count => 2
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "".to_s, :count => 2
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "".to_s, :count => 2
  end
end

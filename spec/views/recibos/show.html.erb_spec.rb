require 'spec_helper'

describe "recibos/show.html.erb" do
  before(:each) do
    @recibo = assign(:recibo, stub_model(Recibo,
      :codigo_barras => "Codigo Barras",
      :contabilizado => false,
      :factura => "",
      :pagocontado => ""
    ))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/Codigo Barras/)
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/false/)
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(//)
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(//)
  end
end

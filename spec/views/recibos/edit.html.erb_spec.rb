require 'spec_helper'

describe "recibos/edit.html.erb" do
  before(:each) do
    @recibo = assign(:recibo, stub_model(Recibo,
      :codigo_barras => "MyString",
      :contabilizado => false,
      :factura => "",
      :pagocontado => ""
    ))
  end

  it "renders the edit recibo form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => recibos_path(@recibo), :method => "post" do
      assert_select "input#recibo_codigo_barras", :name => "recibo[codigo_barras]"
      assert_select "input#recibo_contabilizado", :name => "recibo[contabilizado]"
      assert_select "input#recibo_factura", :name => "recibo[factura]"
      assert_select "input#recibo_pagocontado", :name => "recibo[pagocontado]"
    end
  end
end

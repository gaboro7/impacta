require 'spec_helper'

describe "recibos/new.html.erb" do
  before(:each) do
    assign(:recibo, stub_model(Recibo,
      :codigo_barras => "MyString",
      :contabilizado => false,
      :factura => "",
      :pagocontado => ""
    ).as_new_record)
  end

  it "renders new recibo form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => recibos_path, :method => "post" do
      assert_select "input#recibo_codigo_barras", :name => "recibo[codigo_barras]"
      assert_select "input#recibo_contabilizado", :name => "recibo[contabilizado]"
      assert_select "input#recibo_factura", :name => "recibo[factura]"
      assert_select "input#recibo_pagocontado", :name => "recibo[pagocontado]"
    end
  end
end

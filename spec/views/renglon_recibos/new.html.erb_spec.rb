require 'spec_helper'

describe "renglon_recibos/new.html.erb" do
  before(:each) do
    assign(:renglon_recibo, stub_model(RenglonRecibo,
      :factura_id => "",
      :total_linea => 1.5,
      :total_impuestos => 1.5
    ).as_new_record)
  end

  it "renders new renglon_recibo form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => renglon_recibos_path, :method => "post" do
      assert_select "input#renglon_recibo_factura_id", :name => "renglon_recibo[factura_id]"
      assert_select "input#renglon_recibo_total_linea", :name => "renglon_recibo[total_linea]"
      assert_select "input#renglon_recibo_total_impuestos", :name => "renglon_recibo[total_impuestos]"
    end
  end
end

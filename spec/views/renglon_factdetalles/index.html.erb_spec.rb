require 'spec_helper'

describe "renglon_factdetalles/index.html.erb" do
  before(:each) do
    assign(:renglon_factdetalles, [
      stub_model(RenglonFactdetalle,
        :factura_id => "",
        :detalle => "Detalle",
        :subtotal_linea => 1.5,
        :impuestos => 1.5,
        :total_linea => 1.5
      ),
      stub_model(RenglonFactdetalle,
        :factura_id => "",
        :detalle => "Detalle",
        :subtotal_linea => 1.5,
        :impuestos => 1.5,
        :total_linea => 1.5
      )
    ])
  end

  it "renders a list of renglon_factdetalles" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "".to_s, :count => 2
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "Detalle".to_s, :count => 2
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => 1.5.to_s, :count => 2
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => 1.5.to_s, :count => 2
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => 1.5.to_s, :count => 2
  end
end

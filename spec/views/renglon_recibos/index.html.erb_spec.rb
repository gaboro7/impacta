require 'spec_helper'

describe "renglon_recibos/index.html.erb" do
  before(:each) do
    assign(:renglon_recibos, [
      stub_model(RenglonRecibo,
        :factura_id => "",
        :total_linea => 1.5,
        :total_impuestos => 1.5
      ),
      stub_model(RenglonRecibo,
        :factura_id => "",
        :total_linea => 1.5,
        :total_impuestos => 1.5
      )
    ])
  end

  it "renders a list of renglon_recibos" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "".to_s, :count => 2
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => 1.5.to_s, :count => 2
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => 1.5.to_s, :count => 2
  end
end

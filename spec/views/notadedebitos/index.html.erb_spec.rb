require 'spec_helper'

describe "notadedebitos/index.html.erb" do
  before(:each) do
    assign(:notadedebitos, [
      stub_model(Notadedebito,
        :anulada => false,
        :codigo_barras => "Codigo Barras",
        :comerciante_id => 1,
        :comerciante_type => "Comerciante Type",
        :detalle => "Detalle",
        :impresa => false,
        :sucursal => nil
      ),
      stub_model(Notadedebito,
        :anulada => false,
        :codigo_barras => "Codigo Barras",
        :comerciante_id => 1,
        :comerciante_type => "Comerciante Type",
        :detalle => "Detalle",
        :impresa => false,
        :sucursal => nil
      )
    ])
  end

  it "renders a list of notadedebitos" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => false.to_s, :count => 2
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "Codigo Barras".to_s, :count => 2
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => 1.to_s, :count => 2
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "Comerciante Type".to_s, :count => 2
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "Detalle".to_s, :count => 2
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => false.to_s, :count => 2
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => nil.to_s, :count => 2
  end
end

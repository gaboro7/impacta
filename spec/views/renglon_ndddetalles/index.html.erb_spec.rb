require 'spec_helper'

describe "renglon_ndddetalles/index.html.erb" do
  before(:each) do
    assign(:renglon_ndddetalles, [
      stub_model(RenglonNdddetalle,
        :detalle => "Detalle",
        :notadedebito => nil,
        :total_impuestos => 1.5,
        :total_renglon => 1.5
      ),
      stub_model(RenglonNdddetalle,
        :detalle => "Detalle",
        :notadedebito => nil,
        :total_impuestos => 1.5,
        :total_renglon => 1.5
      )
    ])
  end

  it "renders a list of renglon_ndddetalles" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "Detalle".to_s, :count => 2
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => nil.to_s, :count => 2
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => 1.5.to_s, :count => 2
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => 1.5.to_s, :count => 2
  end
end

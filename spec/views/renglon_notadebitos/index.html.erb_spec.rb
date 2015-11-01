require 'spec_helper'

describe "renglon_notadebitos/index.html.erb" do
  before(:each) do
    assign(:renglon_notadebitos, [
      stub_model(RenglonNotadebito,
        :notadedebito => nil,
        :factura => nil,
        :comentario => "Comentario",
        :cantidad => 1,
        :comercializable => nil,
        :descuento => 1.5,
        :precio_unitario => 1.5,
        :total_impuestos => 1.5,
        :total_renglon => 1.5
      ),
      stub_model(RenglonNotadebito,
        :notadedebito => nil,
        :factura => nil,
        :comentario => "Comentario",
        :cantidad => 1,
        :comercializable => nil,
        :descuento => 1.5,
        :precio_unitario => 1.5,
        :total_impuestos => 1.5,
        :total_renglon => 1.5
      )
    ])
  end

  it "renders a list of renglon_notadebitos" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => nil.to_s, :count => 2
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => nil.to_s, :count => 2
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "Comentario".to_s, :count => 2
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => 1.to_s, :count => 2
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => nil.to_s, :count => 2
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => 1.5.to_s, :count => 2
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => 1.5.to_s, :count => 2
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => 1.5.to_s, :count => 2
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => 1.5.to_s, :count => 2
  end
end

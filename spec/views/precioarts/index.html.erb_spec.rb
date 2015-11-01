require 'spec_helper'

describe "precioarts/index.html.erb" do
  before(:each) do
    assign(:precioarts, [
      stub_model(Precioart,
        :precio => 1.5,
        :descuento => 1.5,
        :comercializable => nil,
        :listaprecio => nil
      ),
      stub_model(Precioart,
        :precio => 1.5,
        :descuento => 1.5,
        :comercializable => nil,
        :listaprecio => nil
      )
    ])
  end

  it "renders a list of precioarts" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => 1.5.to_s, :count => 2
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => 1.5.to_s, :count => 2
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => nil.to_s, :count => 2
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => nil.to_s, :count => 2
  end
end

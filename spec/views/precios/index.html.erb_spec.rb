require 'spec_helper'

describe "precios/index.html.erb" do
  before(:each) do
    assign(:precios, [
      stub_model(Precio,
        :precio => 1.5,
        :descuento => 1.5
      ),
      stub_model(Precio,
        :precio => 1.5,
        :descuento => 1.5
      )
    ])
  end

  it "renders a list of precios" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => 1.5.to_s, :count => 2
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => 1.5.to_s, :count => 2
  end
end

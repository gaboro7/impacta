require 'spec_helper'

describe "comercializables/index.html.erb" do
  before(:each) do
    assign(:comercializables, [
      stub_model(Comercializable,
        :descuento => 1.5,
        :garantia => 1
      ),
      stub_model(Comercializable,
        :descuento => 1.5,
        :garantia => 1
      )
    ])
  end

  it "renders a list of comercializables" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => 1.5.to_s, :count => 2
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => 1.to_s, :count => 2
  end
end

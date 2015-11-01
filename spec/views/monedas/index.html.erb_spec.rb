require 'spec_helper'

describe "monedas/index.html.erb" do
  before(:each) do
    assign(:monedas, [
      stub_model(Moneda,
        :nombre => "Nombre",
        :tipodecambio => 1.5
      ),
      stub_model(Moneda,
        :nombre => "Nombre",
        :tipodecambio => 1.5
      )
    ])
  end

  it "renders a list of monedas" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "Nombre".to_s, :count => 2
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => 1.5.to_s, :count => 2
  end
end

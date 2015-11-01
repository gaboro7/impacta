require 'spec_helper'

describe "sucursals/index.html.erb" do
  before(:each) do
    assign(:sucursals, [
      stub_model(Sucursal,
        :domicilio => "Domicilio"
      ),
      stub_model(Sucursal,
        :domicilio => "Domicilio"
      )
    ])
  end

  it "renders a list of sucursals" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "Domicilio".to_s, :count => 2
  end
end

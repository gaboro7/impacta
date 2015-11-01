require 'spec_helper'

describe "tipoclientes/index.html.erb" do
  before(:each) do
    assign(:tipoclientes, [
      stub_model(Tipocliente,
        :nombre => "Nombre"
      ),
      stub_model(Tipocliente,
        :nombre => "Nombre"
      )
    ])
  end

  it "renders a list of tipoclientes" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "Nombre".to_s, :count => 2
  end
end

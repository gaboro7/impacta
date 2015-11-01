require 'spec_helper'

describe "personas/index.html.erb" do
  before(:each) do
    assign(:personas, [
      stub_model(Persona,
        :nombre => "Nombre",
        :nic => 1,
        :domicilio => "Domicilio"
      ),
      stub_model(Persona,
        :nombre => "Nombre",
        :nic => 1,
        :domicilio => "Domicilio"
      )
    ])
  end

  it "renders a list of personas" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "Nombre".to_s, :count => 2
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => 1.to_s, :count => 2
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "Domicilio".to_s, :count => 2
  end
end

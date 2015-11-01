require 'spec_helper'

describe "contactos/index.html.erb" do
  before(:each) do
    assign(:contactos, [
      stub_model(Contacto,
        :nombre => "Nombre",
        :sector => "Sector",
        :interno => "Interno",
        :horariolle => 1,
        :horariosal => 1
      ),
      stub_model(Contacto,
        :nombre => "Nombre",
        :sector => "Sector",
        :interno => "Interno",
        :horariolle => 1,
        :horariosal => 1
      )
    ])
  end

  it "renders a list of contactos" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "Nombre".to_s, :count => 2
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "Sector".to_s, :count => 2
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "Interno".to_s, :count => 2
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => 1.to_s, :count => 2
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => 1.to_s, :count => 2
  end
end

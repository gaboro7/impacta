require 'spec_helper'

describe "contactos/show.html.erb" do
  before(:each) do
    @contacto = assign(:contacto, stub_model(Contacto,
      :nombre => "Nombre",
      :sector => "Sector",
      :interno => "Interno",
      :horariolle => 1,
      :horariosal => 1
    ))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/Nombre/)
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/Sector/)
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/Interno/)
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/1/)
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/1/)
  end
end

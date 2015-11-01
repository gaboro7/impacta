require 'spec_helper'

describe "personas/show.html.erb" do
  before(:each) do
    @persona = assign(:persona, stub_model(Persona,
      :nombre => "Nombre",
      :nic => 1,
      :domicilio => "Domicilio"
    ))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/Nombre/)
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/1/)
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/Domicilio/)
  end
end

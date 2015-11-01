require 'spec_helper'

describe "sucursals/show.html.erb" do
  before(:each) do
    @sucursal = assign(:sucursal, stub_model(Sucursal,
      :domicilio => "Domicilio"
    ))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/Domicilio/)
  end
end

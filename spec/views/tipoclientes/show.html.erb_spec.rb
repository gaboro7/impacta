require 'spec_helper'

describe "tipoclientes/show.html.erb" do
  before(:each) do
    @tipocliente = assign(:tipocliente, stub_model(Tipocliente,
      :nombre => "Nombre"
    ))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/Nombre/)
  end
end

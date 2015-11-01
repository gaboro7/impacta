require 'spec_helper'

describe "listaprecios/show.html.erb" do
  before(:each) do
    @listaprecio = assign(:listaprecio, stub_model(Listaprecio,
      :nombre => "Nombre",
      :template => false,
      :cliente => nil
    ))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/Nombre/)
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/false/)
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(//)
  end
end

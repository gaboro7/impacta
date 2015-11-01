require 'spec_helper'

describe "formadepagos/show.html.erb" do
  before(:each) do
    @formadepago = assign(:formadepago, stub_model(Formadepago,
      :nombre => "Nombre",
      :utilizada => false
    ))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/Nombre/)
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/false/)
  end
end

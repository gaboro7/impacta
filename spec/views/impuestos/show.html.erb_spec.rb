require 'spec_helper'

describe "impuestos/show.html.erb" do
  before(:each) do
    @impuesto = assign(:impuesto, stub_model(Impuesto,
      :nombre => "Nombre",
      :porcentajea => 1.5,
      :porcentajec => 1.5
    ))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/Nombre/)
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/1.5/)
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/1.5/)
  end
end

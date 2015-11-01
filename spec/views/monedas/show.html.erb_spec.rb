require 'spec_helper'

describe "monedas/show.html.erb" do
  before(:each) do
    @moneda = assign(:moneda, stub_model(Moneda,
      :nombre => "Nombre",
      :tipodecambio => 1.5
    ))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/Nombre/)
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/1.5/)
  end
end

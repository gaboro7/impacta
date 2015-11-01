require 'spec_helper'

describe "precios/show.html.erb" do
  before(:each) do
    @precio = assign(:precio, stub_model(Precio,
      :precio => 1.5,
      :descuento => 1.5
    ))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/1.5/)
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/1.5/)
  end
end

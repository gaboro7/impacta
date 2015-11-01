require 'spec_helper'

describe "precioarts/show.html.erb" do
  before(:each) do
    @precioart = assign(:precioart, stub_model(Precioart,
      :precio => 1.5,
      :descuento => 1.5,
      :comercializable => nil,
      :listaprecio => nil
    ))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/1.5/)
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/1.5/)
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(//)
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(//)
  end
end

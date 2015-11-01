require 'spec_helper'

describe "promocions/show.html.erb" do
  before(:each) do
    @promocion = assign(:promocion, stub_model(Promocion,
      :descuento => 1.5
    ))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/1.5/)
  end
end

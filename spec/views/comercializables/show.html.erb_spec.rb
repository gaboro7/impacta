require 'spec_helper'

describe "comercializables/show.html.erb" do
  before(:each) do
    @comercializable = assign(:comercializable, stub_model(Comercializable,
      :descuento => 1.5,
      :garantia => 1
    ))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/1.5/)
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/1/)
  end
end

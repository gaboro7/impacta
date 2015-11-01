require 'spec_helper'

describe "domicilios/show.html.erb" do
  before(:each) do
    @domicilio = assign(:domicilio, stub_model(Domicilio,
      :domicilio => "Domicilio",
      :condomicilio_id => 1,
      :condomicilio_type => "Condomicilio Type"
    ))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/Domicilio/)
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/1/)
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/Condomicilio Type/)
  end
end

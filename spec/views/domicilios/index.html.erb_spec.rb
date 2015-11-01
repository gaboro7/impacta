require 'spec_helper'

describe "domicilios/index.html.erb" do
  before(:each) do
    assign(:domicilios, [
      stub_model(Domicilio,
        :domicilio => "Domicilio",
        :condomicilio_id => 1,
        :condomicilio_type => "Condomicilio Type"
      ),
      stub_model(Domicilio,
        :domicilio => "Domicilio",
        :condomicilio_id => 1,
        :condomicilio_type => "Condomicilio Type"
      )
    ])
  end

  it "renders a list of domicilios" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "Domicilio".to_s, :count => 2
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => 1.to_s, :count => 2
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "Condomicilio Type".to_s, :count => 2
  end
end

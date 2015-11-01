require 'spec_helper'

describe "impuestos/index.html.erb" do
  before(:each) do
    assign(:impuestos, [
      stub_model(Impuesto,
        :nombre => "Nombre",
        :porcentajea => 1.5,
        :porcentajec => 1.5
      ),
      stub_model(Impuesto,
        :nombre => "Nombre",
        :porcentajea => 1.5,
        :porcentajec => 1.5
      )
    ])
  end

  it "renders a list of impuestos" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "Nombre".to_s, :count => 2
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => 1.5.to_s, :count => 2
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => 1.5.to_s, :count => 2
  end
end

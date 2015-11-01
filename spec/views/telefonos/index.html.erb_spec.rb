require 'spec_helper'

describe "telefonos/index.html.erb" do
  before(:each) do
    assign(:telefonos, [
      stub_model(Telefono,
        :telefono => "Telefono",
        :contelefono_id => 1,
        :contelefono_type => "Contelefono Type"
      ),
      stub_model(Telefono,
        :telefono => "Telefono",
        :contelefono_id => 1,
        :contelefono_type => "Contelefono Type"
      )
    ])
  end

  it "renders a list of telefonos" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "Telefono".to_s, :count => 2
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => 1.to_s, :count => 2
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "Contelefono Type".to_s, :count => 2
  end
end

require 'spec_helper'

describe "telefonos/show.html.erb" do
  before(:each) do
    @telefono = assign(:telefono, stub_model(Telefono,
      :telefono => "Telefono",
      :contelefono_id => 1,
      :contelefono_type => "Contelefono Type"
    ))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/Telefono/)
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/1/)
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/Contelefono Type/)
  end
end

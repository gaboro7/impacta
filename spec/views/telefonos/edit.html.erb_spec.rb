require 'spec_helper'

describe "telefonos/edit.html.erb" do
  before(:each) do
    @telefono = assign(:telefono, stub_model(Telefono,
      :telefono => "MyString",
      :contelefono_id => 1,
      :contelefono_type => "MyString"
    ))
  end

  it "renders the edit telefono form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => telefonos_path(@telefono), :method => "post" do
      assert_select "input#telefono_telefono", :name => "telefono[telefono]"
      assert_select "input#telefono_contelefono_id", :name => "telefono[contelefono_id]"
      assert_select "input#telefono_contelefono_type", :name => "telefono[contelefono_type]"
    end
  end
end

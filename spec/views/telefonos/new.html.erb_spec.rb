require 'spec_helper'

describe "telefonos/new.html.erb" do
  before(:each) do
    assign(:telefono, stub_model(Telefono,
      :telefono => "MyString",
      :contelefono_id => 1,
      :contelefono_type => "MyString"
    ).as_new_record)
  end

  it "renders new telefono form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => telefonos_path, :method => "post" do
      assert_select "input#telefono_telefono", :name => "telefono[telefono]"
      assert_select "input#telefono_contelefono_id", :name => "telefono[contelefono_id]"
      assert_select "input#telefono_contelefono_type", :name => "telefono[contelefono_type]"
    end
  end
end

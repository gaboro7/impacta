require 'spec_helper'

describe "impuestos/new.html.erb" do
  before(:each) do
    assign(:impuesto, stub_model(Impuesto,
      :nombre => "MyString",
      :porcentajea => 1.5,
      :porcentajec => 1.5
    ).as_new_record)
  end

  it "renders new impuesto form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => impuestos_path, :method => "post" do
      assert_select "input#impuesto_nombre", :name => "impuesto[nombre]"
      assert_select "input#impuesto_porcentajea", :name => "impuesto[porcentajea]"
      assert_select "input#impuesto_porcentajec", :name => "impuesto[porcentajec]"
    end
  end
end

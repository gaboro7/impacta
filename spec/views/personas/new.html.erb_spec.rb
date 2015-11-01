require 'spec_helper'

describe "personas/new.html.erb" do
  before(:each) do
    assign(:persona, stub_model(Persona,
      :nombre => "MyString",
      :nic => 1,
      :domicilio => "MyString"
    ).as_new_record)
  end

  it "renders new persona form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => personas_path, :method => "post" do
      assert_select "input#persona_nombre", :name => "persona[nombre]"
      assert_select "input#persona_nic", :name => "persona[nic]"
      assert_select "input#persona_domicilio", :name => "persona[domicilio]"
    end
  end
end

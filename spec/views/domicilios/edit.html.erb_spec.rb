require 'spec_helper'

describe "domicilios/edit.html.erb" do
  before(:each) do
    @domicilio = assign(:domicilio, stub_model(Domicilio,
      :domicilio => "MyString",
      :condomicilio_id => 1,
      :condomicilio_type => "MyString"
    ))
  end

  it "renders the edit domicilio form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => domicilios_path(@domicilio), :method => "post" do
      assert_select "input#domicilio_domicilio", :name => "domicilio[domicilio]"
      assert_select "input#domicilio_condomicilio_id", :name => "domicilio[condomicilio_id]"
      assert_select "input#domicilio_condomicilio_type", :name => "domicilio[condomicilio_type]"
    end
  end
end

require 'spec_helper'

describe "sucursals/new.html.erb" do
  before(:each) do
    assign(:sucursal, stub_model(Sucursal,
      :domicilio => "MyString"
    ).as_new_record)
  end

  it "renders new sucursal form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => sucursals_path, :method => "post" do
      assert_select "input#sucursal_domicilio", :name => "sucursal[domicilio]"
    end
  end
end

require 'spec_helper'

describe "sucursals/edit.html.erb" do
  before(:each) do
    @sucursal = assign(:sucursal, stub_model(Sucursal,
      :domicilio => "MyString"
    ))
  end

  it "renders the edit sucursal form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => sucursals_path(@sucursal), :method => "post" do
      assert_select "input#sucursal_domicilio", :name => "sucursal[domicilio]"
    end
  end
end

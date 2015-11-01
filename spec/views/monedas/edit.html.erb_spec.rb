require 'spec_helper'

describe "monedas/edit.html.erb" do
  before(:each) do
    @moneda = assign(:moneda, stub_model(Moneda,
      :nombre => "MyString",
      :tipodecambio => 1.5
    ))
  end

  it "renders the edit moneda form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => monedas_path(@moneda), :method => "post" do
      assert_select "input#moneda_nombre", :name => "moneda[nombre]"
      assert_select "input#moneda_tipodecambio", :name => "moneda[tipodecambio]"
    end
  end
end

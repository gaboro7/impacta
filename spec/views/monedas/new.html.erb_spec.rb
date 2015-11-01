require 'spec_helper'

describe "monedas/new.html.erb" do
  before(:each) do
    assign(:moneda, stub_model(Moneda,
      :nombre => "MyString",
      :tipodecambio => 1.5
    ).as_new_record)
  end

  it "renders new moneda form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => monedas_path, :method => "post" do
      assert_select "input#moneda_nombre", :name => "moneda[nombre]"
      assert_select "input#moneda_tipodecambio", :name => "moneda[tipodecambio]"
    end
  end
end

require 'spec_helper'

describe "notadecreditos/new.html.erb" do
  before(:each) do
    assign(:notadecredito, stub_model(Notadecredito,
      :anulada => false,
      :codigo_barras => "MyString",
      :comerciante_id => 1,
      :comerciante_type => "MyString",
      :detalle => "MyString",
      :impresa => false,
      :sucursal => nil
    ).as_new_record)
  end

  it "renders new notadecredito form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => notadecreditos_path, :method => "post" do
      assert_select "input#notadecredito_anulada", :name => "notadecredito[anulada]"
      assert_select "input#notadecredito_codigo_barras", :name => "notadecredito[codigo_barras]"
      assert_select "input#notadecredito_comerciante_id", :name => "notadecredito[comerciante_id]"
      assert_select "input#notadecredito_comerciante_type", :name => "notadecredito[comerciante_type]"
      assert_select "input#notadecredito_detalle", :name => "notadecredito[detalle]"
      assert_select "input#notadecredito_impresa", :name => "notadecredito[impresa]"
      assert_select "input#notadecredito_sucursal", :name => "notadecredito[sucursal]"
    end
  end
end

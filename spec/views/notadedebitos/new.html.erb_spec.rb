require 'spec_helper'

describe "notadedebitos/new.html.erb" do
  before(:each) do
    assign(:notadedebito, stub_model(Notadedebito,
      :anulada => false,
      :codigo_barras => "MyString",
      :comerciante_id => 1,
      :comerciante_type => "MyString",
      :detalle => "MyString",
      :impresa => false,
      :sucursal => nil
    ).as_new_record)
  end

  it "renders new notadedebito form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => notadedebitos_path, :method => "post" do
      assert_select "input#notadedebito_anulada", :name => "notadedebito[anulada]"
      assert_select "input#notadedebito_codigo_barras", :name => "notadedebito[codigo_barras]"
      assert_select "input#notadedebito_comerciante_id", :name => "notadedebito[comerciante_id]"
      assert_select "input#notadedebito_comerciante_type", :name => "notadedebito[comerciante_type]"
      assert_select "input#notadedebito_detalle", :name => "notadedebito[detalle]"
      assert_select "input#notadedebito_impresa", :name => "notadedebito[impresa]"
      assert_select "input#notadedebito_sucursal", :name => "notadedebito[sucursal]"
    end
  end
end

require 'spec_helper'

describe "renglon_factdetalles/new.html.erb" do
  before(:each) do
    assign(:renglon_factdetalle, stub_model(RenglonFactdetalle,
      :factura_id => "",
      :detalle => "MyString",
      :subtotal_linea => 1.5,
      :impuestos => 1.5,
      :total_linea => 1.5
    ).as_new_record)
  end

  it "renders new renglon_factdetalle form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => renglon_factdetalles_path, :method => "post" do
      assert_select "input#renglon_factdetalle_factura_id", :name => "renglon_factdetalle[factura_id]"
      assert_select "input#renglon_factdetalle_detalle", :name => "renglon_factdetalle[detalle]"
      assert_select "input#renglon_factdetalle_subtotal_linea", :name => "renglon_factdetalle[subtotal_linea]"
      assert_select "input#renglon_factdetalle_impuestos", :name => "renglon_factdetalle[impuestos]"
      assert_select "input#renglon_factdetalle_total_linea", :name => "renglon_factdetalle[total_linea]"
    end
  end
end

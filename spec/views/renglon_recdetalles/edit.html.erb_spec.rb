require 'spec_helper'

describe "renglon_recdetalles/edit.html.erb" do
  before(:each) do
    @renglon_recdetalle = assign(:renglon_recdetalle, stub_model(RenglonRecdetalle,
      :recibo_id => "",
      :detalle => "MyString",
      :subtotal_linea => 1.5,
      :impuestos => 1.5,
      :total_linea => 1.5
    ))
  end

  it "renders the edit renglon_recdetalle form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => renglon_recdetalles_path(@renglon_recdetalle), :method => "post" do
      assert_select "input#renglon_recdetalle_recibo_id", :name => "renglon_recdetalle[recibo_id]"
      assert_select "input#renglon_recdetalle_detalle", :name => "renglon_recdetalle[detalle]"
      assert_select "input#renglon_recdetalle_subtotal_linea", :name => "renglon_recdetalle[subtotal_linea]"
      assert_select "input#renglon_recdetalle_impuestos", :name => "renglon_recdetalle[impuestos]"
      assert_select "input#renglon_recdetalle_total_linea", :name => "renglon_recdetalle[total_linea]"
    end
  end
end

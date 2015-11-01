require 'spec_helper'

describe "renglon_ndc_articulos/new" do
  before(:each) do
    assign(:renglon_ndc_articulo, stub_model(RenglonNdcArticulo,
      :comercializable => nil,
      :cantidad => 1,
      :precio => "",
      :total_renglon => 1.5,
      :total_impuestos => 1.5,
      :descuento => 1.5,
      :comentario => "MyString"
    ).as_new_record)
  end

  it "renders new renglon_ndc_articulo form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => renglon_ndc_articulos_path, :method => "post" do
      assert_select "input#renglon_ndc_articulo_comercializable", :name => "renglon_ndc_articulo[comercializable]"
      assert_select "input#renglon_ndc_articulo_cantidad", :name => "renglon_ndc_articulo[cantidad]"
      assert_select "input#renglon_ndc_articulo_precio", :name => "renglon_ndc_articulo[precio]"
      assert_select "input#renglon_ndc_articulo_total_renglon", :name => "renglon_ndc_articulo[total_renglon]"
      assert_select "input#renglon_ndc_articulo_total_impuestos", :name => "renglon_ndc_articulo[total_impuestos]"
      assert_select "input#renglon_ndc_articulo_descuento", :name => "renglon_ndc_articulo[descuento]"
      assert_select "input#renglon_ndc_articulo_comentario", :name => "renglon_ndc_articulo[comentario]"
    end
  end
end

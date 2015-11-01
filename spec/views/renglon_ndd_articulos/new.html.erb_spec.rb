require 'spec_helper'

describe "renglon_ndd_articulos/new" do
  before(:each) do
    assign(:renglon_ndd_articulo, stub_model(RenglonNddArticulo,
      :comercializable => nil,
      :cantidad => 1,
      :precio => "",
      :total_renglon => 1.5,
      :total_impuestos => 1.5,
      :descuento => 1.5,
      :comentario => "MyString"
    ).as_new_record)
  end

  it "renders new renglon_ndd_articulo form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => renglon_ndd_articulos_path, :method => "post" do
      assert_select "input#renglon_ndd_articulo_comercializable", :name => "renglon_ndd_articulo[comercializable]"
      assert_select "input#renglon_ndd_articulo_cantidad", :name => "renglon_ndd_articulo[cantidad]"
      assert_select "input#renglon_ndd_articulo_precio", :name => "renglon_ndd_articulo[precio]"
      assert_select "input#renglon_ndd_articulo_total_renglon", :name => "renglon_ndd_articulo[total_renglon]"
      assert_select "input#renglon_ndd_articulo_total_impuestos", :name => "renglon_ndd_articulo[total_impuestos]"
      assert_select "input#renglon_ndd_articulo_descuento", :name => "renglon_ndd_articulo[descuento]"
      assert_select "input#renglon_ndd_articulo_comentario", :name => "renglon_ndd_articulo[comentario]"
    end
  end
end

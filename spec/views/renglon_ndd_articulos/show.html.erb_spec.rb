require 'spec_helper'

describe "renglon_ndd_articulos/show" do
  before(:each) do
    @renglon_ndd_articulo = assign(:renglon_ndd_articulo, stub_model(RenglonNddArticulo,
      :comercializable => nil,
      :cantidad => 1,
      :precio => "",
      :total_renglon => 1.5,
      :total_impuestos => 1.5,
      :descuento => 1.5,
      :comentario => "Comentario"
    ))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(//)
    rendered.should match(/1/)
    rendered.should match(//)
    rendered.should match(/1.5/)
    rendered.should match(/1.5/)
    rendered.should match(/1.5/)
    rendered.should match(/Comentario/)
  end
end

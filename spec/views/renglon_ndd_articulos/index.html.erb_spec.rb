require 'spec_helper'

describe "renglon_ndd_articulos/index" do
  before(:each) do
    assign(:renglon_ndd_articulos, [
      stub_model(RenglonNddArticulo,
        :comercializable => nil,
        :cantidad => 1,
        :precio => "",
        :total_renglon => 1.5,
        :total_impuestos => 1.5,
        :descuento => 1.5,
        :comentario => "Comentario"
      ),
      stub_model(RenglonNddArticulo,
        :comercializable => nil,
        :cantidad => 1,
        :precio => "",
        :total_renglon => 1.5,
        :total_impuestos => 1.5,
        :descuento => 1.5,
        :comentario => "Comentario"
      )
    ])
  end

  it "renders a list of renglon_ndd_articulos" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => nil.to_s, :count => 2
    assert_select "tr>td", :text => 1.to_s, :count => 2
    assert_select "tr>td", :text => "".to_s, :count => 2
    assert_select "tr>td", :text => 1.5.to_s, :count => 2
    assert_select "tr>td", :text => 1.5.to_s, :count => 2
    assert_select "tr>td", :text => 1.5.to_s, :count => 2
    assert_select "tr>td", :text => "Comentario".to_s, :count => 2
  end
end

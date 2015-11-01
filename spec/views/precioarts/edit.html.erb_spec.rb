require 'spec_helper'

describe "precioarts/edit.html.erb" do
  before(:each) do
    @precioart = assign(:precioart, stub_model(Precioart,
      :precio => 1.5,
      :descuento => 1.5,
      :comercializable => nil,
      :listaprecio => nil
    ))
  end

  it "renders the edit precioart form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => precioarts_path(@precioart), :method => "post" do
      assert_select "input#precioart_precio", :name => "precioart[precio]"
      assert_select "input#precioart_descuento", :name => "precioart[descuento]"
      assert_select "input#precioart_comercializable", :name => "precioart[comercializable]"
      assert_select "input#precioart_listaprecio", :name => "precioart[listaprecio]"
    end
  end
end

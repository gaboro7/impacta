require 'spec_helper'

describe "precios/edit.html.erb" do
  before(:each) do
    @precio = assign(:precio, stub_model(Precio,
      :precio => 1.5,
      :descuento => 1.5
    ))
  end

  it "renders the edit precio form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => precios_path(@precio), :method => "post" do
      assert_select "input#precio_precio", :name => "precio[precio]"
      assert_select "input#precio_descuento", :name => "precio[descuento]"
    end
  end
end

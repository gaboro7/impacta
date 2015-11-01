require 'spec_helper'

describe "precios/new.html.erb" do
  before(:each) do
    assign(:precio, stub_model(Precio,
      :precio => 1.5,
      :descuento => 1.5
    ).as_new_record)
  end

  it "renders new precio form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => precios_path, :method => "post" do
      assert_select "input#precio_precio", :name => "precio[precio]"
      assert_select "input#precio_descuento", :name => "precio[descuento]"
    end
  end
end

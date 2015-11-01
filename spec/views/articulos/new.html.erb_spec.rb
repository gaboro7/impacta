require 'spec_helper'

describe "articulos/new.html.erb" do
  before(:each) do
    assign(:articulo, stub_model(Articulo,
      :nombre => "MyString",
      :descripcion => "MyString"
    ).as_new_record)
  end

  it "renders new articulo form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => articulos_path, :method => "post" do
      assert_select "input#articulo_nombre", :name => "articulo[nombre]"
      assert_select "input#articulo_descripcion", :name => "articulo[descripcion]"
    end
  end
end

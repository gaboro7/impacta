require 'spec_helper'

describe "articulos/edit.html.erb" do
  before(:each) do
    @articulo = assign(:articulo, stub_model(Articulo,
      :nombre => "MyString",
      :descripcion => "MyString"
    ))
  end

  it "renders the edit articulo form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => articulos_path(@articulo), :method => "post" do
      assert_select "input#articulo_nombre", :name => "articulo[nombre]"
      assert_select "input#articulo_descripcion", :name => "articulo[descripcion]"
    end
  end
end

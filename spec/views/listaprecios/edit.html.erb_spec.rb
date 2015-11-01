require 'spec_helper'

describe "listaprecios/edit.html.erb" do
  before(:each) do
    @listaprecio = assign(:listaprecio, stub_model(Listaprecio,
      :nombre => "MyString",
      :template => false,
      :cliente => nil
    ))
  end

  it "renders the edit listaprecio form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => listaprecios_path(@listaprecio), :method => "post" do
      assert_select "input#listaprecio_nombre", :name => "listaprecio[nombre]"
      assert_select "input#listaprecio_template", :name => "listaprecio[template]"
      assert_select "input#listaprecio_cliente", :name => "listaprecio[cliente]"
    end
  end
end

require 'spec_helper'

describe "listaprecios/new.html.erb" do
  before(:each) do
    assign(:listaprecio, stub_model(Listaprecio,
      :nombre => "MyString",
      :template => false,
      :cliente => nil
    ).as_new_record)
  end

  it "renders new listaprecio form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => listaprecios_path, :method => "post" do
      assert_select "input#listaprecio_nombre", :name => "listaprecio[nombre]"
      assert_select "input#listaprecio_template", :name => "listaprecio[template]"
      assert_select "input#listaprecio_cliente", :name => "listaprecio[cliente]"
    end
  end
end

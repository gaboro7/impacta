require 'spec_helper'

describe "articulos/index.html.erb" do
  before(:each) do
    assign(:articulos, [
      stub_model(Articulo,
        :nombre => "Nombre",
        :descripcion => "Descripcion"
      ),
      stub_model(Articulo,
        :nombre => "Nombre",
        :descripcion => "Descripcion"
      )
    ])
  end

  it "renders a list of articulos" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "Nombre".to_s, :count => 2
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "Descripcion".to_s, :count => 2
  end
end

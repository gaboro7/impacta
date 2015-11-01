require 'spec_helper'

describe "listaprecios/index.html.erb" do
  before(:each) do
    assign(:listaprecios, [
      stub_model(Listaprecio,
        :nombre => "Nombre",
        :template => false,
        :cliente => nil
      ),
      stub_model(Listaprecio,
        :nombre => "Nombre",
        :template => false,
        :cliente => nil
      )
    ])
  end

  it "renders a list of listaprecios" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "Nombre".to_s, :count => 2
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => false.to_s, :count => 2
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => nil.to_s, :count => 2
  end
end

require 'spec_helper'

describe "clientes/index.html.erb" do
  before(:each) do
    assign(:clientes, [
      stub_model(Cliente,
        :credito => false,
        :precargo => 1.5,
        :urecargo => 1,
        :trecargo => "",
        :pdescuento => 1,
        :habilitado => false
      ),
      stub_model(Cliente,
        :credito => false,
        :precargo => 1.5,
        :urecargo => 1,
        :trecargo => "",
        :pdescuento => 1,
        :habilitado => false
      )
    ])
  end

  it "renders a list of clientes" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => false.to_s, :count => 2
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => 1.5.to_s, :count => 2
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => 1.to_s, :count => 2
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "".to_s, :count => 2
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => 1.to_s, :count => 2
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => false.to_s, :count => 2
  end
end

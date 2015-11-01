require 'spec_helper'

describe "formadepagos/index.html.erb" do
  before(:each) do
    assign(:formadepagos, [
      stub_model(Formadepago,
        :nombre => "Nombre",
        :utilizada => false
      ),
      stub_model(Formadepago,
        :nombre => "Nombre",
        :utilizada => false
      )
    ])
  end

  it "renders a list of formadepagos" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "Nombre".to_s, :count => 2
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => false.to_s, :count => 2
  end
end

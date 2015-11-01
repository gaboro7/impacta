require 'spec_helper'

describe "tipoclientes/edit.html.erb" do
  before(:each) do
    @tipocliente = assign(:tipocliente, stub_model(Tipocliente,
      :nombre => "MyString"
    ))
  end

  it "renders the edit tipocliente form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => tipoclientes_path(@tipocliente), :method => "post" do
      assert_select "input#tipocliente_nombre", :name => "tipocliente[nombre]"
    end
  end
end

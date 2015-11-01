require 'spec_helper'

describe "tipoclientes/new.html.erb" do
  before(:each) do
    assign(:tipocliente, stub_model(Tipocliente,
      :nombre => "MyString"
    ).as_new_record)
  end

  it "renders new tipocliente form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => tipoclientes_path, :method => "post" do
      assert_select "input#tipocliente_nombre", :name => "tipocliente[nombre]"
    end
  end
end

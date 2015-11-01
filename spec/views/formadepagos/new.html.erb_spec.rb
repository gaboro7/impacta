require 'spec_helper'

describe "formadepagos/new.html.erb" do
  before(:each) do
    assign(:formadepago, stub_model(Formadepago,
      :nombre => "MyString",
      :utilizada => false
    ).as_new_record)
  end

  it "renders new formadepago form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => formadepagos_path, :method => "post" do
      assert_select "input#formadepago_nombre", :name => "formadepago[nombre]"
      assert_select "input#formadepago_utilizada", :name => "formadepago[utilizada]"
    end
  end
end

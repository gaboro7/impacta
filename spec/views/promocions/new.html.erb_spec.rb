require 'spec_helper'

describe "promocions/new.html.erb" do
  before(:each) do
    assign(:promocion, stub_model(Promocion,
      :descuento => 1.5
    ).as_new_record)
  end

  it "renders new promocion form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => promocions_path, :method => "post" do
      assert_select "input#promocion_descuento", :name => "promocion[descuento]"
    end
  end
end

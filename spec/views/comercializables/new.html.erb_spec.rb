require 'spec_helper'

describe "comercializables/new.html.erb" do
  before(:each) do
    assign(:comercializable, stub_model(Comercializable,
      :descuento => 1.5,
      :garantia => 1
    ).as_new_record)
  end

  it "renders new comercializable form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => comercializables_path, :method => "post" do
      assert_select "input#comercializable_descuento", :name => "comercializable[descuento]"
      assert_select "input#comercializable_garantia", :name => "comercializable[garantia]"
    end
  end
end

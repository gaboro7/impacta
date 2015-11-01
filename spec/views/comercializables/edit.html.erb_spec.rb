require 'spec_helper'

describe "comercializables/edit.html.erb" do
  before(:each) do
    @comercializable = assign(:comercializable, stub_model(Comercializable,
      :descuento => 1.5,
      :garantia => 1
    ))
  end

  it "renders the edit comercializable form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => comercializables_path(@comercializable), :method => "post" do
      assert_select "input#comercializable_descuento", :name => "comercializable[descuento]"
      assert_select "input#comercializable_garantia", :name => "comercializable[garantia]"
    end
  end
end

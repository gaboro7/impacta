require 'spec_helper'

describe "promocions/edit.html.erb" do
  before(:each) do
    @promocion = assign(:promocion, stub_model(Promocion,
      :descuento => 1.5
    ))
  end

  it "renders the edit promocion form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => promocions_path(@promocion), :method => "post" do
      assert_select "input#promocion_descuento", :name => "promocion[descuento]"
    end
  end
end

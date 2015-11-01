require 'spec_helper'

describe "renglon_ndddetalles/edit.html.erb" do
  before(:each) do
    @renglon_ndddetalle = assign(:renglon_ndddetalle, stub_model(RenglonNdddetalle,
      :detalle => "MyString",
      :notadedebito => nil,
      :total_impuestos => 1.5,
      :total_renglon => 1.5
    ))
  end

  it "renders the edit renglon_ndddetalle form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => renglon_ndddetalles_path(@renglon_ndddetalle), :method => "post" do
      assert_select "input#renglon_ndddetalle_detalle", :name => "renglon_ndddetalle[detalle]"
      assert_select "input#renglon_ndddetalle_notadedebito", :name => "renglon_ndddetalle[notadedebito]"
      assert_select "input#renglon_ndddetalle_total_impuestos", :name => "renglon_ndddetalle[total_impuestos]"
      assert_select "input#renglon_ndddetalle_total_renglon", :name => "renglon_ndddetalle[total_renglon]"
    end
  end
end

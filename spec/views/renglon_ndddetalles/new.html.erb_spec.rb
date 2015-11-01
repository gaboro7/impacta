require 'spec_helper'

describe "renglon_ndddetalles/new.html.erb" do
  before(:each) do
    assign(:renglon_ndddetalle, stub_model(RenglonNdddetalle,
      :detalle => "MyString",
      :notadedebito => nil,
      :total_impuestos => 1.5,
      :total_renglon => 1.5
    ).as_new_record)
  end

  it "renders new renglon_ndddetalle form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => renglon_ndddetalles_path, :method => "post" do
      assert_select "input#renglon_ndddetalle_detalle", :name => "renglon_ndddetalle[detalle]"
      assert_select "input#renglon_ndddetalle_notadedebito", :name => "renglon_ndddetalle[notadedebito]"
      assert_select "input#renglon_ndddetalle_total_impuestos", :name => "renglon_ndddetalle[total_impuestos]"
      assert_select "input#renglon_ndddetalle_total_renglon", :name => "renglon_ndddetalle[total_renglon]"
    end
  end
end

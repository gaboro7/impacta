require 'spec_helper'

describe "renglon_nddndcs/new.html.erb" do
  before(:each) do
    assign(:renglon_nddndc, stub_model(RenglonNddndc,
      :notadecredito => nil,
      :notadedebito => nil,
      :detalle => "MyString",
      :total_renglon => 1.5,
      :total_impuestos => 1.5
    ).as_new_record)
  end

  it "renders new renglon_nddndc form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => renglon_nddndcs_path, :method => "post" do
      assert_select "input#renglon_nddndc_notadecredito", :name => "renglon_nddndc[notadecredito]"
      assert_select "input#renglon_nddndc_notadedebito", :name => "renglon_nddndc[notadedebito]"
      assert_select "input#renglon_nddndc_detalle", :name => "renglon_nddndc[detalle]"
      assert_select "input#renglon_nddndc_total_renglon", :name => "renglon_nddndc[total_renglon]"
      assert_select "input#renglon_nddndc_total_impuestos", :name => "renglon_nddndc[total_impuestos]"
    end
  end
end

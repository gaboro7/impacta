require 'spec_helper'

describe "renglon_ndcndds/new.html.erb" do
  before(:each) do
    assign(:renglon_ndcndd, stub_model(RenglonNdcndd,
      :notadecredito => nil,
      :notadedebito => nil,
      :detalle => "MyString",
      :total_renglon => 1.5,
      :total_impuestos => 1.5
    ).as_new_record)
  end

  it "renders new renglon_ndcndd form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => renglon_ndcndds_path, :method => "post" do
      assert_select "input#renglon_ndcndd_notadecredito", :name => "renglon_ndcndd[notadecredito]"
      assert_select "input#renglon_ndcndd_notadedebito", :name => "renglon_ndcndd[notadedebito]"
      assert_select "input#renglon_ndcndd_detalle", :name => "renglon_ndcndd[detalle]"
      assert_select "input#renglon_ndcndd_total_renglon", :name => "renglon_ndcndd[total_renglon]"
      assert_select "input#renglon_ndcndd_total_impuestos", :name => "renglon_ndcndd[total_impuestos]"
    end
  end
end

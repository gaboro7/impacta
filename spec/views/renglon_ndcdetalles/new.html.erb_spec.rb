require 'spec_helper'

describe "renglon_ndcdetalles/new.html.erb" do
  before(:each) do
    assign(:renglon_ndcdetalle, stub_model(RenglonNdcdetalle,
      :detalle => "MyString",
      :notadecredito => nil,
      :total_impuestos => 1.5,
      :total_renglon => 1.5
    ).as_new_record)
  end

  it "renders new renglon_ndcdetalle form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => renglon_ndcdetalles_path, :method => "post" do
      assert_select "input#renglon_ndcdetalle_detalle", :name => "renglon_ndcdetalle[detalle]"
      assert_select "input#renglon_ndcdetalle_notadecredito", :name => "renglon_ndcdetalle[notadecredito]"
      assert_select "input#renglon_ndcdetalle_total_impuestos", :name => "renglon_ndcdetalle[total_impuestos]"
      assert_select "input#renglon_ndcdetalle_total_renglon", :name => "renglon_ndcdetalle[total_renglon]"
    end
  end
end

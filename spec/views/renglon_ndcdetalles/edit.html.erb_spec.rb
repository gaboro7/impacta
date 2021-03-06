require 'spec_helper'

describe "renglon_ndcdetalles/edit.html.erb" do
  before(:each) do
    @renglon_ndcdetalle = assign(:renglon_ndcdetalle, stub_model(RenglonNdcdetalle,
      :detalle => "MyString",
      :notadecredito => nil,
      :total_impuestos => 1.5,
      :total_renglon => 1.5
    ))
  end

  it "renders the edit renglon_ndcdetalle form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => renglon_ndcdetalles_path(@renglon_ndcdetalle), :method => "post" do
      assert_select "input#renglon_ndcdetalle_detalle", :name => "renglon_ndcdetalle[detalle]"
      assert_select "input#renglon_ndcdetalle_notadecredito", :name => "renglon_ndcdetalle[notadecredito]"
      assert_select "input#renglon_ndcdetalle_total_impuestos", :name => "renglon_ndcdetalle[total_impuestos]"
      assert_select "input#renglon_ndcdetalle_total_renglon", :name => "renglon_ndcdetalle[total_renglon]"
    end
  end
end

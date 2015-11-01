require 'spec_helper'

describe "renglon_recibo_docs/edit" do
  before(:each) do
    @renglon_recibo_doc = assign(:renglon_recibo_doc, stub_model(RenglonReciboDoc,
      :recibo => nil,
      :documento_id => 1,
      :documento_type => "MyString",
      :total_renglon => 1.5,
      :total_impuestos => 1.5,
      :detalle => "MyString"
    ))
  end

  it "renders the edit renglon_recibo_doc form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => renglon_recibo_docs_path(@renglon_recibo_doc), :method => "post" do
      assert_select "input#renglon_recibo_doc_recibo", :name => "renglon_recibo_doc[recibo]"
      assert_select "input#renglon_recibo_doc_documento_id", :name => "renglon_recibo_doc[documento_id]"
      assert_select "input#renglon_recibo_doc_documento_type", :name => "renglon_recibo_doc[documento_type]"
      assert_select "input#renglon_recibo_doc_total_renglon", :name => "renglon_recibo_doc[total_renglon]"
      assert_select "input#renglon_recibo_doc_total_impuestos", :name => "renglon_recibo_doc[total_impuestos]"
      assert_select "input#renglon_recibo_doc_detalle", :name => "renglon_recibo_doc[detalle]"
    end
  end
end

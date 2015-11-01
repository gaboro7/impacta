require 'spec_helper'

describe "renglon_recibo_docs/index" do
  before(:each) do
    assign(:renglon_recibo_docs, [
      stub_model(RenglonReciboDoc,
        :recibo => nil,
        :documento_id => 1,
        :documento_type => "Documento Type",
        :total_renglon => 1.5,
        :total_impuestos => 1.5,
        :detalle => "Detalle"
      ),
      stub_model(RenglonReciboDoc,
        :recibo => nil,
        :documento_id => 1,
        :documento_type => "Documento Type",
        :total_renglon => 1.5,
        :total_impuestos => 1.5,
        :detalle => "Detalle"
      )
    ])
  end

  it "renders a list of renglon_recibo_docs" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => nil.to_s, :count => 2
    assert_select "tr>td", :text => 1.to_s, :count => 2
    assert_select "tr>td", :text => "Documento Type".to_s, :count => 2
    assert_select "tr>td", :text => 1.5.to_s, :count => 2
    assert_select "tr>td", :text => 1.5.to_s, :count => 2
    assert_select "tr>td", :text => "Detalle".to_s, :count => 2
  end
end

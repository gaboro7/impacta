require 'spec_helper'

describe "renglon_recibo_docs/show" do
  before(:each) do
    @renglon_recibo_doc = assign(:renglon_recibo_doc, stub_model(RenglonReciboDoc,
      :recibo => nil,
      :documento_id => 1,
      :documento_type => "Documento Type",
      :total_renglon => 1.5,
      :total_impuestos => 1.5,
      :detalle => "Detalle"
    ))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(//)
    rendered.should match(/1/)
    rendered.should match(/Documento Type/)
    rendered.should match(/1.5/)
    rendered.should match(/1.5/)
    rendered.should match(/Detalle/)
  end
end

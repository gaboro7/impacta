require 'spec_helper'

describe "renglon_recibos/show.html.erb" do
  before(:each) do
    @renglon_recibo = assign(:renglon_recibo, stub_model(RenglonRecibo,
      :factura_id => "",
      :total_linea => 1.5,
      :total_impuestos => 1.5
    ))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(//)
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/1.5/)
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/1.5/)
  end
end

require 'spec_helper'

describe "renglon_notacreditos/show.html.erb" do
  before(:each) do
    @renglon_notacredito = assign(:renglon_notacredito, stub_model(RenglonNotacredito,
      :notadecredito => nil,
      :factura => nil,
      :comentario => "Comentario",
      :cantidad => 1,
      :comercializable => nil,
      :descuento => 1.5,
      :precio_unitario => 1.5,
      :total_impuestos => 1.5,
      :total_renglon => 1.5
    ))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(//)
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(//)
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/Comentario/)
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/1/)
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(//)
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/1.5/)
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/1.5/)
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/1.5/)
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/1.5/)
  end
end

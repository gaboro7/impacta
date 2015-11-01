require 'spec_helper'

describe "notadedebitos/show.html.erb" do
  before(:each) do
    @notadedebito = assign(:notadedebito, stub_model(Notadedebito,
      :anulada => false,
      :codigo_barras => "Codigo Barras",
      :comerciante_id => 1,
      :comerciante_type => "Comerciante Type",
      :detalle => "Detalle",
      :impresa => false,
      :sucursal => nil
    ))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/false/)
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/Codigo Barras/)
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/1/)
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/Comerciante Type/)
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/Detalle/)
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/false/)
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(//)
  end
end

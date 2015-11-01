require 'spec_helper'

describe "pagocontados/index.html.erb" do
  before(:each) do
    assign(:pagocontados, [
      stub_model(Pagocontado),
      stub_model(Pagocontado)
    ])
  end

  it "renders a list of pagocontados" do
    render
  end
end

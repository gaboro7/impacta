require 'spec_helper'

describe "articulocomps/index.html.erb" do
  before(:each) do
    assign(:articulocomps, [
      stub_model(Articulocomp),
      stub_model(Articulocomp)
    ])
  end

  it "renders a list of articulocomps" do
    render
  end
end

require 'spec_helper'

describe "articuloinds/index.html.erb" do
  before(:each) do
    assign(:articuloinds, [
      stub_model(Articuloind),
      stub_model(Articuloind)
    ])
  end

  it "renders a list of articuloinds" do
    render
  end
end

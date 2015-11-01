require 'spec_helper'

describe "articuloinds/show.html.erb" do
  before(:each) do
    @articuloind = assign(:articuloind, stub_model(Articuloind))
  end

  it "renders attributes in <p>" do
    render
  end
end

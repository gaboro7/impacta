require 'spec_helper'

describe "articulocomps/show.html.erb" do
  before(:each) do
    @articulocomp = assign(:articulocomp, stub_model(Articulocomp))
  end

  it "renders attributes in <p>" do
    render
  end
end

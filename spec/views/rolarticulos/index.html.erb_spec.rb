require 'spec_helper'

describe "rolarticulos/index.html.erb" do
  before(:each) do
    assign(:rolarticulos, [
      stub_model(Rolarticulo),
      stub_model(Rolarticulo)
    ])
  end

  it "renders a list of rolarticulos" do
    render
  end
end

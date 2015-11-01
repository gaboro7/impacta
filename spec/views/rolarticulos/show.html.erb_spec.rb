require 'spec_helper'

describe "rolarticulos/show.html.erb" do
  before(:each) do
    @rolarticulo = assign(:rolarticulo, stub_model(Rolarticulo))
  end

  it "renders attributes in <p>" do
    render
  end
end

require 'spec_helper'

describe "pagocontados/show.html.erb" do
  before(:each) do
    @pagocontado = assign(:pagocontado, stub_model(Pagocontado))
  end

  it "renders attributes in <p>" do
    render
  end
end

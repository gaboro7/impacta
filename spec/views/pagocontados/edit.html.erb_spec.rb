require 'spec_helper'

describe "pagocontados/edit.html.erb" do
  before(:each) do
    @pagocontado = assign(:pagocontado, stub_model(Pagocontado))
  end

  it "renders the edit pagocontado form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => pagocontados_path(@pagocontado), :method => "post" do
    end
  end
end

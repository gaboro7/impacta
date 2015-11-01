require 'spec_helper'

describe "pagocontados/new.html.erb" do
  before(:each) do
    assign(:pagocontado, stub_model(Pagocontado).as_new_record)
  end

  it "renders new pagocontado form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => pagocontados_path, :method => "post" do
    end
  end
end

require 'spec_helper'

describe "rolarticulos/new.html.erb" do
  before(:each) do
    assign(:rolarticulo, stub_model(Rolarticulo).as_new_record)
  end

  it "renders new rolarticulo form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => rolarticulos_path, :method => "post" do
    end
  end
end

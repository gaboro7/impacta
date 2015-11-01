require 'spec_helper'

describe "empresas/show.html.erb" do
  before(:each) do
    @empresa = assign(:empresa, stub_model(Empresa,
      :nombrereal => "Nombrereal",
      :nombrefiscal => "Nombrefiscal",
      :nif => 1,
      :domiciliocent => "Domiciliocent",
      :dirweb => "Dirweb"
    ))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/Nombrereal/)
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/Nombrefiscal/)
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/1/)
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/Domiciliocent/)
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/Dirweb/)
  end
end

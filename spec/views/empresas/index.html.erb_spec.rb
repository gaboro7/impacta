require 'spec_helper'

describe "empresas/index.html.erb" do
  before(:each) do
    assign(:empresas, [
      stub_model(Empresa,
        :nombrereal => "Nombrereal",
        :nombrefiscal => "Nombrefiscal",
        :nif => 1,
        :domiciliocent => "Domiciliocent",
        :dirweb => "Dirweb"
      ),
      stub_model(Empresa,
        :nombrereal => "Nombrereal",
        :nombrefiscal => "Nombrefiscal",
        :nif => 1,
        :domiciliocent => "Domiciliocent",
        :dirweb => "Dirweb"
      )
    ])
  end

  it "renders a list of empresas" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "Nombrereal".to_s, :count => 2
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "Nombrefiscal".to_s, :count => 2
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => 1.to_s, :count => 2
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "Domiciliocent".to_s, :count => 2
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "Dirweb".to_s, :count => 2
  end
end

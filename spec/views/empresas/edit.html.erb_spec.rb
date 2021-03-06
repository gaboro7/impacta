require 'spec_helper'

describe "empresas/edit.html.erb" do
  before(:each) do
    @empresa = assign(:empresa, stub_model(Empresa,
      :nombrereal => "MyString",
      :nombrefiscal => "MyString",
      :nif => 1,
      :domiciliocent => "MyString",
      :dirweb => "MyString"
    ))
  end

  it "renders the edit empresa form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => empresas_path(@empresa), :method => "post" do
      assert_select "input#empresa_nombrereal", :name => "empresa[nombrereal]"
      assert_select "input#empresa_nombrefiscal", :name => "empresa[nombrefiscal]"
      assert_select "input#empresa_nif", :name => "empresa[nif]"
      assert_select "input#empresa_domiciliocent", :name => "empresa[domiciliocent]"
      assert_select "input#empresa_dirweb", :name => "empresa[dirweb]"
    end
  end
end

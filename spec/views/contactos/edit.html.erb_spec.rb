require 'spec_helper'

describe "contactos/edit.html.erb" do
  before(:each) do
    @contacto = assign(:contacto, stub_model(Contacto,
      :nombre => "MyString",
      :sector => "MyString",
      :interno => "MyString",
      :horariolle => 1,
      :horariosal => 1
    ))
  end

  it "renders the edit contacto form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => contactos_path(@contacto), :method => "post" do
      assert_select "input#contacto_nombre", :name => "contacto[nombre]"
      assert_select "input#contacto_sector", :name => "contacto[sector]"
      assert_select "input#contacto_interno", :name => "contacto[interno]"
      assert_select "input#contacto_horariolle", :name => "contacto[horariolle]"
      assert_select "input#contacto_horariosal", :name => "contacto[horariosal]"
    end
  end
end

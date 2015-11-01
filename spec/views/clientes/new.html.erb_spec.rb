require 'spec_helper'

describe "clientes/new.html.erb" do
  before(:each) do
    assign(:cliente, stub_model(Cliente,
      :credito => false,
      :precargo => 1.5,
      :urecargo => 1,
      :trecargo => "",
      :pdescuento => 1,
      :habilitado => false
    ).as_new_record)
  end

  it "renders new cliente form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => clientes_path, :method => "post" do
      assert_select "input#cliente_credito", :name => "cliente[credito]"
      assert_select "input#cliente_precargo", :name => "cliente[precargo]"
      assert_select "input#cliente_urecargo", :name => "cliente[urecargo]"
      assert_select "input#cliente_trecargo", :name => "cliente[trecargo]"
      assert_select "input#cliente_pdescuento", :name => "cliente[pdescuento]"
      assert_select "input#cliente_habilitado", :name => "cliente[habilitado]"
    end
  end
end

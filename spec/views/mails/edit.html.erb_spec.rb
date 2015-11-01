require 'spec_helper'

describe "mails/edit" do
  before(:each) do
    @mail = assign(:mail, stub_model(MailInterno,
      :mail => "MyString"
    ))
  end

  it "renders the edit mail form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => mails_path(@mail), :method => "post" do
      assert_select "input#mail_mail", :name => "mail[mail]"
    end
  end
end

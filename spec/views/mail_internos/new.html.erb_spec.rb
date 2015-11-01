require 'spec_helper'

describe "mails/new" do
  before(:each) do
    assign(:mail, stub_model(MailInterno,
      :mail => "MyString"
    ).as_new_record)
  end

  it "renders new mail form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => mails_path, :method => "post" do
      assert_select "input#mail_mail", :name => "mail[mail]"
    end
  end
end

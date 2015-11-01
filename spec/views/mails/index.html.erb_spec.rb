require 'spec_helper'

describe "mails/index" do
  before(:each) do
    assign(:mails, [
      stub_model(MailInterno,
        :mail => "MailInterno"
      ),
      stub_model(MailInterno,
        :mail => "MailInterno"
      )
    ])
  end

  it "renders a list of mails" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "MailInterno".to_s, :count => 2
  end
end

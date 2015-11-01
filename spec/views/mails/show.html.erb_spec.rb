require 'spec_helper'

describe "mails/show" do
  before(:each) do
    @mail = assign(:mail, stub_model(MailInterno,
      :mail => "MailInterno"
    ))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/MailInterno/)
  end
end

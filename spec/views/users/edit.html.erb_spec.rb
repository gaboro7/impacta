require 'spec_helper'

describe "users/edit.html.erb" do
  before(:each) do
    @user = assign(:user, stub_model(User,
      :nombre => "MyString",
      :email => "MyString",
      :encrypted_password => "MyString",
      :salt => "MyString"
    ))
  end

  it "renders the edit user form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => users_path(@user), :method => "post" do
      assert_select "input#user_nombre", :name => "user[nombre]"
      assert_select "input#user_email", :name => "user[email]"
      assert_select "input#user_encrypted_password", :name => "user[encrypted_password]"
      assert_select "input#user_salt", :name => "user[salt]"
    end
  end
end

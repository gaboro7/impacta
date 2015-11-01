require 'spec_helper'

describe "RenglonNotadebitos" do
  describe "GET /renglon_notadebitos" do
    it "works! (now write some real specs)" do
      # Run the generator again with the --webrat flag if you want to use webrat methods/matchers
      get renglon_notadebitos_path
      response.status.should be(200)
    end
  end
end

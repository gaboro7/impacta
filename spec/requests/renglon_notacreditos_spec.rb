require 'spec_helper'

describe "RenglonNotacreditos" do
  describe "GET /renglon_notacreditos" do
    it "works! (now write some real specs)" do
      # Run the generator again with the --webrat flag if you want to use webrat methods/matchers
      get renglon_notacreditos_path
      response.status.should be(200)
    end
  end
end

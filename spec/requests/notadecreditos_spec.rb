require 'spec_helper'

describe "Notadecreditos" do
  describe "GET /notadecreditos" do
    it "works! (now write some real specs)" do
      # Run the generator again with the --webrat flag if you want to use webrat methods/matchers
      get notadecreditos_path
      response.status.should be(200)
    end
  end
end

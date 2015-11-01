require 'spec_helper'

describe "Articuloinds" do
  describe "GET /articuloinds" do
    it "works! (now write some real specs)" do
      # Run the generator again with the --webrat flag if you want to use webrat methods/matchers
      get articuloinds_path
      response.status.should be(200)
    end
  end
end

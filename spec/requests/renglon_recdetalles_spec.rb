require 'spec_helper'

describe "RenglonRecdetalles" do
  describe "GET /renglon_recdetalles" do
    it "works! (now write some real specs)" do
      # Run the generator again with the --webrat flag if you want to use webrat methods/matchers
      get renglon_recdetalles_path
      response.status.should be(200)
    end
  end
end

require 'spec_helper'

describe "RenglonRecibos" do
  describe "GET /renglon_recibos" do
    it "works! (now write some real specs)" do
      # Run the generator again with the --webrat flag if you want to use webrat methods/matchers
      get renglon_recibos_path
      response.status.should be(200)
    end
  end
end

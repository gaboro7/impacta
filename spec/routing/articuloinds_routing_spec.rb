require "spec_helper"

describe ArticuloindsController do
  describe "routing" do

    it "routes to #index" do
      get("/articuloinds").should route_to("articuloinds#index")
    end

    it "routes to #new" do
      get("/articuloinds/new").should route_to("articuloinds#new")
    end

    it "routes to #show" do
      get("/articuloinds/1").should route_to("articuloinds#show", :id => "1")
    end

    it "routes to #edit" do
      get("/articuloinds/1/edit").should route_to("articuloinds#edit", :id => "1")
    end

    it "routes to #create" do
      post("/articuloinds").should route_to("articuloinds#create")
    end

    it "routes to #update" do
      put("/articuloinds/1").should route_to("articuloinds#update", :id => "1")
    end

    it "routes to #destroy" do
      delete("/articuloinds/1").should route_to("articuloinds#destroy", :id => "1")
    end

  end
end

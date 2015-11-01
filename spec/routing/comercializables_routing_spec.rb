require "spec_helper"

describe ComercializablesController do
  describe "routing" do

    it "routes to #index" do
      get("/comercializables").should route_to("comercializables#index")
    end

    it "routes to #new" do
      get("/comercializables/new").should route_to("comercializables#new")
    end

    it "routes to #show" do
      get("/comercializables/1").should route_to("comercializables#show", :id => "1")
    end

    it "routes to #edit" do
      get("/comercializables/1/edit").should route_to("comercializables#edit", :id => "1")
    end

    it "routes to #create" do
      post("/comercializables").should route_to("comercializables#create")
    end

    it "routes to #update" do
      put("/comercializables/1").should route_to("comercializables#update", :id => "1")
    end

    it "routes to #destroy" do
      delete("/comercializables/1").should route_to("comercializables#destroy", :id => "1")
    end

  end
end

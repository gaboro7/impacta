require "spec_helper"

describe TipoclientesController do
  describe "routing" do

    it "routes to #index" do
      get("/tipoclientes").should route_to("tipoclientes#index")
    end

    it "routes to #new" do
      get("/tipoclientes/new").should route_to("tipoclientes#new")
    end

    it "routes to #show" do
      get("/tipoclientes/1").should route_to("tipoclientes#show", :id => "1")
    end

    it "routes to #edit" do
      get("/tipoclientes/1/edit").should route_to("tipoclientes#edit", :id => "1")
    end

    it "routes to #create" do
      post("/tipoclientes").should route_to("tipoclientes#create")
    end

    it "routes to #update" do
      put("/tipoclientes/1").should route_to("tipoclientes#update", :id => "1")
    end

    it "routes to #destroy" do
      delete("/tipoclientes/1").should route_to("tipoclientes#destroy", :id => "1")
    end

  end
end

require "spec_helper"

describe NotadecreditosController do
  describe "routing" do

    it "routes to #index" do
      get("/notadecreditos").should route_to("notadecreditos#index")
    end

    it "routes to #new" do
      get("/notadecreditos/new").should route_to("notadecreditos#new")
    end

    it "routes to #show" do
      get("/notadecreditos/1").should route_to("notadecreditos#show", :id => "1")
    end

    it "routes to #edit" do
      get("/notadecreditos/1/edit").should route_to("notadecreditos#edit", :id => "1")
    end

    it "routes to #create" do
      post("/notadecreditos").should route_to("notadecreditos#create")
    end

    it "routes to #update" do
      put("/notadecreditos/1").should route_to("notadecreditos#update", :id => "1")
    end

    it "routes to #destroy" do
      delete("/notadecreditos/1").should route_to("notadecreditos#destroy", :id => "1")
    end

  end
end

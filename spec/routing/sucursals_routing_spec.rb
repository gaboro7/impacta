require "spec_helper"

describe SucursalsController do
  describe "routing" do

    it "routes to #index" do
      get("/sucursals").should route_to("sucursals#index")
    end

    it "routes to #new" do
      get("/sucursals/new").should route_to("sucursals#new")
    end

    it "routes to #show" do
      get("/sucursals/1").should route_to("sucursals#show", :id => "1")
    end

    it "routes to #edit" do
      get("/sucursals/1/edit").should route_to("sucursals#edit", :id => "1")
    end

    it "routes to #create" do
      post("/sucursals").should route_to("sucursals#create")
    end

    it "routes to #update" do
      put("/sucursals/1").should route_to("sucursals#update", :id => "1")
    end

    it "routes to #destroy" do
      delete("/sucursals/1").should route_to("sucursals#destroy", :id => "1")
    end

  end
end

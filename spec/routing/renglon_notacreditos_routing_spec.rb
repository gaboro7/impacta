require "spec_helper"

describe RenglonNotacreditosController do
  describe "routing" do

    it "routes to #index" do
      get("/renglon_notacreditos").should route_to("renglon_notacreditos#index")
    end

    it "routes to #new" do
      get("/renglon_notacreditos/new").should route_to("renglon_notacreditos#new")
    end

    it "routes to #show" do
      get("/renglon_notacreditos/1").should route_to("renglon_notacreditos#show", :id => "1")
    end

    it "routes to #edit" do
      get("/renglon_notacreditos/1/edit").should route_to("renglon_notacreditos#edit", :id => "1")
    end

    it "routes to #create" do
      post("/renglon_notacreditos").should route_to("renglon_notacreditos#create")
    end

    it "routes to #update" do
      put("/renglon_notacreditos/1").should route_to("renglon_notacreditos#update", :id => "1")
    end

    it "routes to #destroy" do
      delete("/renglon_notacreditos/1").should route_to("renglon_notacreditos#destroy", :id => "1")
    end

  end
end

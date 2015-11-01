require "spec_helper"

describe PrecioartsController do
  describe "routing" do

    it "routes to #index" do
      get("/precioarts").should route_to("precioarts#index")
    end

    it "routes to #new" do
      get("/precioarts/new").should route_to("precioarts#new")
    end

    it "routes to #show" do
      get("/precioarts/1").should route_to("precioarts#show", :id => "1")
    end

    it "routes to #edit" do
      get("/precioarts/1/edit").should route_to("precioarts#edit", :id => "1")
    end

    it "routes to #create" do
      post("/precioarts").should route_to("precioarts#create")
    end

    it "routes to #update" do
      put("/precioarts/1").should route_to("precioarts#update", :id => "1")
    end

    it "routes to #destroy" do
      delete("/precioarts/1").should route_to("precioarts#destroy", :id => "1")
    end

  end
end

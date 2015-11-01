require "spec_helper"

describe FacturasController do
  describe "routing" do

    it "routes to #index" do
      get("/facturas").should route_to("facturas#index")
    end

    it "routes to #new" do
      get("/facturas/new").should route_to("facturas#new")
    end

    it "routes to #show" do
      get("/facturas/1").should route_to("facturas#show", :id => "1")
    end

    it "routes to #edit" do
      get("/facturas/1/edit").should route_to("facturas#edit", :id => "1")
    end

    it "routes to #create" do
      post("/facturas").should route_to("facturas#create")
    end

    it "routes to #update" do
      put("/facturas/1").should route_to("facturas#update", :id => "1")
    end

    it "routes to #destroy" do
      delete("/facturas/1").should route_to("facturas#destroy", :id => "1")
    end

  end
end

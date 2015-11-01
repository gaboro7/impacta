require "spec_helper"

describe RenglonFacturasController do
  describe "routing" do

    it "routes to #index" do
      get("/renglon_facturas").should route_to("renglon_facturas#index")
    end

    it "routes to #new" do
      get("/renglon_facturas/new").should route_to("renglon_facturas#new")
    end

    it "routes to #show" do
      get("/renglon_facturas/1").should route_to("renglon_facturas#show", :id => "1")
    end

    it "routes to #edit" do
      get("/renglon_facturas/1/edit").should route_to("renglon_facturas#edit", :id => "1")
    end

    it "routes to #create" do
      post("/renglon_facturas").should route_to("renglon_facturas#create")
    end

    it "routes to #update" do
      put("/renglon_facturas/1").should route_to("renglon_facturas#update", :id => "1")
    end

    it "routes to #destroy" do
      delete("/renglon_facturas/1").should route_to("renglon_facturas#destroy", :id => "1")
    end

  end
end

require "spec_helper"

describe DescuentoClientesController do
  describe "routing" do

    it "routes to #index" do
      get("/descuento_clientes").should route_to("descuento_clientes#index")
    end

    it "routes to #new" do
      get("/descuento_clientes/new").should route_to("descuento_clientes#new")
    end

    it "routes to #show" do
      get("/descuento_clientes/1").should route_to("descuento_clientes#show", :id => "1")
    end

    it "routes to #edit" do
      get("/descuento_clientes/1/edit").should route_to("descuento_clientes#edit", :id => "1")
    end

    it "routes to #create" do
      post("/descuento_clientes").should route_to("descuento_clientes#create")
    end

    it "routes to #update" do
      put("/descuento_clientes/1").should route_to("descuento_clientes#update", :id => "1")
    end

    it "routes to #destroy" do
      delete("/descuento_clientes/1").should route_to("descuento_clientes#destroy", :id => "1")
    end

  end
end

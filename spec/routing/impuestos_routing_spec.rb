require "spec_helper"

describe ImpuestosController do
  describe "routing" do

    it "routes to #index" do
      get("/impuestos").should route_to("impuestos#index")
    end

    it "routes to #new" do
      get("/impuestos/new").should route_to("impuestos#new")
    end

    it "routes to #show" do
      get("/impuestos/1").should route_to("impuestos#show", :id => "1")
    end

    it "routes to #edit" do
      get("/impuestos/1/edit").should route_to("impuestos#edit", :id => "1")
    end

    it "routes to #create" do
      post("/impuestos").should route_to("impuestos#create")
    end

    it "routes to #update" do
      put("/impuestos/1").should route_to("impuestos#update", :id => "1")
    end

    it "routes to #destroy" do
      delete("/impuestos/1").should route_to("impuestos#destroy", :id => "1")
    end

  end
end

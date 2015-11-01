require "spec_helper"

describe ArticulocompsController do
  describe "routing" do

    it "routes to #index" do
      get("/articulocomps").should route_to("articulocomps#index")
    end

    it "routes to #new" do
      get("/articulocomps/new").should route_to("articulocomps#new")
    end

    it "routes to #show" do
      get("/articulocomps/1").should route_to("articulocomps#show", :id => "1")
    end

    it "routes to #edit" do
      get("/articulocomps/1/edit").should route_to("articulocomps#edit", :id => "1")
    end

    it "routes to #create" do
      post("/articulocomps").should route_to("articulocomps#create")
    end

    it "routes to #update" do
      put("/articulocomps/1").should route_to("articulocomps#update", :id => "1")
    end

    it "routes to #destroy" do
      delete("/articulocomps/1").should route_to("articulocomps#destroy", :id => "1")
    end

  end
end

require "spec_helper"

describe RenglonNdddetallesController do
  describe "routing" do

    it "routes to #index" do
      get("/renglon_ndddetalles").should route_to("renglon_ndddetalles#index")
    end

    it "routes to #new" do
      get("/renglon_ndddetalles/new").should route_to("renglon_ndddetalles#new")
    end

    it "routes to #show" do
      get("/renglon_ndddetalles/1").should route_to("renglon_ndddetalles#show", :id => "1")
    end

    it "routes to #edit" do
      get("/renglon_ndddetalles/1/edit").should route_to("renglon_ndddetalles#edit", :id => "1")
    end

    it "routes to #create" do
      post("/renglon_ndddetalles").should route_to("renglon_ndddetalles#create")
    end

    it "routes to #update" do
      put("/renglon_ndddetalles/1").should route_to("renglon_ndddetalles#update", :id => "1")
    end

    it "routes to #destroy" do
      delete("/renglon_ndddetalles/1").should route_to("renglon_ndddetalles#destroy", :id => "1")
    end

  end
end

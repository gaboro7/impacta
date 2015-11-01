require "spec_helper"

describe RenglonNdcdetallesController do
  describe "routing" do

    it "routes to #index" do
      get("/renglon_ndcdetalles").should route_to("renglon_ndcdetalles#index")
    end

    it "routes to #new" do
      get("/renglon_ndcdetalles/new").should route_to("renglon_ndcdetalles#new")
    end

    it "routes to #show" do
      get("/renglon_ndcdetalles/1").should route_to("renglon_ndcdetalles#show", :id => "1")
    end

    it "routes to #edit" do
      get("/renglon_ndcdetalles/1/edit").should route_to("renglon_ndcdetalles#edit", :id => "1")
    end

    it "routes to #create" do
      post("/renglon_ndcdetalles").should route_to("renglon_ndcdetalles#create")
    end

    it "routes to #update" do
      put("/renglon_ndcdetalles/1").should route_to("renglon_ndcdetalles#update", :id => "1")
    end

    it "routes to #destroy" do
      delete("/renglon_ndcdetalles/1").should route_to("renglon_ndcdetalles#destroy", :id => "1")
    end

  end
end

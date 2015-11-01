require "spec_helper"

describe RenglonFactdetallesController do
  describe "routing" do

    it "routes to #index" do
      get("/renglon_factdetalles").should route_to("renglon_factdetalles#index")
    end

    it "routes to #new" do
      get("/renglon_factdetalles/new").should route_to("renglon_factdetalles#new")
    end

    it "routes to #show" do
      get("/renglon_factdetalles/1").should route_to("renglon_factdetalles#show", :id => "1")
    end

    it "routes to #edit" do
      get("/renglon_factdetalles/1/edit").should route_to("renglon_factdetalles#edit", :id => "1")
    end

    it "routes to #create" do
      post("/renglon_factdetalles").should route_to("renglon_factdetalles#create")
    end

    it "routes to #update" do
      put("/renglon_factdetalles/1").should route_to("renglon_factdetalles#update", :id => "1")
    end

    it "routes to #destroy" do
      delete("/renglon_factdetalles/1").should route_to("renglon_factdetalles#destroy", :id => "1")
    end

  end
end

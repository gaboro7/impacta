require "spec_helper"

describe RenglonRecdetallesController do
  describe "routing" do

    it "routes to #index" do
      get("/renglon_recdetalles").should route_to("renglon_recdetalles#index")
    end

    it "routes to #new" do
      get("/renglon_recdetalles/new").should route_to("renglon_recdetalles#new")
    end

    it "routes to #show" do
      get("/renglon_recdetalles/1").should route_to("renglon_recdetalles#show", :id => "1")
    end

    it "routes to #edit" do
      get("/renglon_recdetalles/1/edit").should route_to("renglon_recdetalles#edit", :id => "1")
    end

    it "routes to #create" do
      post("/renglon_recdetalles").should route_to("renglon_recdetalles#create")
    end

    it "routes to #update" do
      put("/renglon_recdetalles/1").should route_to("renglon_recdetalles#update", :id => "1")
    end

    it "routes to #destroy" do
      delete("/renglon_recdetalles/1").should route_to("renglon_recdetalles#destroy", :id => "1")
    end

  end
end

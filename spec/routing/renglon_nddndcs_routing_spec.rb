require "spec_helper"

describe RenglonNddndcsController do
  describe "routing" do

    it "routes to #index" do
      get("/renglon_nddndcs").should route_to("renglon_nddndcs#index")
    end

    it "routes to #new" do
      get("/renglon_nddndcs/new").should route_to("renglon_nddndcs#new")
    end

    it "routes to #show" do
      get("/renglon_nddndcs/1").should route_to("renglon_nddndcs#show", :id => "1")
    end

    it "routes to #edit" do
      get("/renglon_nddndcs/1/edit").should route_to("renglon_nddndcs#edit", :id => "1")
    end

    it "routes to #create" do
      post("/renglon_nddndcs").should route_to("renglon_nddndcs#create")
    end

    it "routes to #update" do
      put("/renglon_nddndcs/1").should route_to("renglon_nddndcs#update", :id => "1")
    end

    it "routes to #destroy" do
      delete("/renglon_nddndcs/1").should route_to("renglon_nddndcs#destroy", :id => "1")
    end

  end
end

require "spec_helper"

describe DomiciliosController do
  describe "routing" do

    it "routes to #index" do
      get("/domicilios").should route_to("domicilios#index")
    end

    it "routes to #new" do
      get("/domicilios/new").should route_to("domicilios#new")
    end

    it "routes to #show" do
      get("/domicilios/1").should route_to("domicilios#show", :id => "1")
    end

    it "routes to #edit" do
      get("/domicilios/1/edit").should route_to("domicilios#edit", :id => "1")
    end

    it "routes to #create" do
      post("/domicilios").should route_to("domicilios#create")
    end

    it "routes to #update" do
      put("/domicilios/1").should route_to("domicilios#update", :id => "1")
    end

    it "routes to #destroy" do
      delete("/domicilios/1").should route_to("domicilios#destroy", :id => "1")
    end

  end
end

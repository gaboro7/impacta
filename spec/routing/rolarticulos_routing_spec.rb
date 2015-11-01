require "spec_helper"

describe RolarticulosController do
  describe "routing" do

    it "routes to #index" do
      get("/rolarticulos").should route_to("rolarticulos#index")
    end

    it "routes to #new" do
      get("/rolarticulos/new").should route_to("rolarticulos#new")
    end

    it "routes to #show" do
      get("/rolarticulos/1").should route_to("rolarticulos#show", :id => "1")
    end

    it "routes to #edit" do
      get("/rolarticulos/1/edit").should route_to("rolarticulos#edit", :id => "1")
    end

    it "routes to #create" do
      post("/rolarticulos").should route_to("rolarticulos#create")
    end

    it "routes to #update" do
      put("/rolarticulos/1").should route_to("rolarticulos#update", :id => "1")
    end

    it "routes to #destroy" do
      delete("/rolarticulos/1").should route_to("rolarticulos#destroy", :id => "1")
    end

  end
end

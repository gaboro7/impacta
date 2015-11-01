require "spec_helper"

describe PagoacreditosController do
  describe "routing" do

    it "routes to #index" do
      get("/pagoacreditos").should route_to("pagoacreditos#index")
    end

    it "routes to #new" do
      get("/pagoacreditos/new").should route_to("pagoacreditos#new")
    end

    it "routes to #show" do
      get("/pagoacreditos/1").should route_to("pagoacreditos#show", :id => "1")
    end

    it "routes to #edit" do
      get("/pagoacreditos/1/edit").should route_to("pagoacreditos#edit", :id => "1")
    end

    it "routes to #create" do
      post("/pagoacreditos").should route_to("pagoacreditos#create")
    end

    it "routes to #update" do
      put("/pagoacreditos/1").should route_to("pagoacreditos#update", :id => "1")
    end

    it "routes to #destroy" do
      delete("/pagoacreditos/1").should route_to("pagoacreditos#destroy", :id => "1")
    end

  end
end

require "spec_helper"

describe FormadepagosController do
  describe "routing" do

    it "routes to #index" do
      get("/formadepagos").should route_to("formadepagos#index")
    end

    it "routes to #new" do
      get("/formadepagos/new").should route_to("formadepagos#new")
    end

    it "routes to #show" do
      get("/formadepagos/1").should route_to("formadepagos#show", :id => "1")
    end

    it "routes to #edit" do
      get("/formadepagos/1/edit").should route_to("formadepagos#edit", :id => "1")
    end

    it "routes to #create" do
      post("/formadepagos").should route_to("formadepagos#create")
    end

    it "routes to #update" do
      put("/formadepagos/1").should route_to("formadepagos#update", :id => "1")
    end

    it "routes to #destroy" do
      delete("/formadepagos/1").should route_to("formadepagos#destroy", :id => "1")
    end

  end
end

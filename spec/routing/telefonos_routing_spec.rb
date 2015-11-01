require "spec_helper"

describe TelefonosController do
  describe "routing" do

    it "routes to #index" do
      get("/telefonos").should route_to("telefonos#index")
    end

    it "routes to #new" do
      get("/telefonos/new").should route_to("telefonos#new")
    end

    it "routes to #show" do
      get("/telefonos/1").should route_to("telefonos#show", :id => "1")
    end

    it "routes to #edit" do
      get("/telefonos/1/edit").should route_to("telefonos#edit", :id => "1")
    end

    it "routes to #create" do
      post("/telefonos").should route_to("telefonos#create")
    end

    it "routes to #update" do
      put("/telefonos/1").should route_to("telefonos#update", :id => "1")
    end

    it "routes to #destroy" do
      delete("/telefonos/1").should route_to("telefonos#destroy", :id => "1")
    end

  end
end

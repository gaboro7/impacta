require "spec_helper"

describe RecibosController do
  describe "routing" do

    it "routes to #index" do
      get("/recibos").should route_to("recibos#index")
    end

    it "routes to #new" do
      get("/recibos/new").should route_to("recibos#new")
    end

    it "routes to #show" do
      get("/recibos/1").should route_to("recibos#show", :id => "1")
    end

    it "routes to #edit" do
      get("/recibos/1/edit").should route_to("recibos#edit", :id => "1")
    end

    it "routes to #create" do
      post("/recibos").should route_to("recibos#create")
    end

    it "routes to #update" do
      put("/recibos/1").should route_to("recibos#update", :id => "1")
    end

    it "routes to #destroy" do
      delete("/recibos/1").should route_to("recibos#destroy", :id => "1")
    end

  end
end

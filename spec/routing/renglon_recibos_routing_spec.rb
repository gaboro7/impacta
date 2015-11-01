require "spec_helper"

describe RenglonRecibosController do
  describe "routing" do

    it "routes to #index" do
      get("/renglon_recibos").should route_to("renglon_recibos#index")
    end

    it "routes to #new" do
      get("/renglon_recibos/new").should route_to("renglon_recibos#new")
    end

    it "routes to #show" do
      get("/renglon_recibos/1").should route_to("renglon_recibos#show", :id => "1")
    end

    it "routes to #edit" do
      get("/renglon_recibos/1/edit").should route_to("renglon_recibos#edit", :id => "1")
    end

    it "routes to #create" do
      post("/renglon_recibos").should route_to("renglon_recibos#create")
    end

    it "routes to #update" do
      put("/renglon_recibos/1").should route_to("renglon_recibos#update", :id => "1")
    end

    it "routes to #destroy" do
      delete("/renglon_recibos/1").should route_to("renglon_recibos#destroy", :id => "1")
    end

  end
end

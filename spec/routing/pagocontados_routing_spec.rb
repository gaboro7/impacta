require "spec_helper"

describe PagocontadosController do
  describe "routing" do

    it "routes to #index" do
      get("/pagocontados").should route_to("pagocontados#index")
    end

    it "routes to #new" do
      get("/pagocontados/new").should route_to("pagocontados#new")
    end

    it "routes to #show" do
      get("/pagocontados/1").should route_to("pagocontados#show", :id => "1")
    end

    it "routes to #edit" do
      get("/pagocontados/1/edit").should route_to("pagocontados#edit", :id => "1")
    end

    it "routes to #create" do
      post("/pagocontados").should route_to("pagocontados#create")
    end

    it "routes to #update" do
      put("/pagocontados/1").should route_to("pagocontados#update", :id => "1")
    end

    it "routes to #destroy" do
      delete("/pagocontados/1").should route_to("pagocontados#destroy", :id => "1")
    end

  end
end

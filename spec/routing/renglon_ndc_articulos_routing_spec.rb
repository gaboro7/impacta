require "spec_helper"

describe RenglonNdcArticulosController do
  describe "routing" do

    it "routes to #index" do
      get("/renglon_ndc_articulos").should route_to("renglon_ndc_articulos#index")
    end

    it "routes to #new" do
      get("/renglon_ndc_articulos/new").should route_to("renglon_ndc_articulos#new")
    end

    it "routes to #show" do
      get("/renglon_ndc_articulos/1").should route_to("renglon_ndc_articulos#show", :id => "1")
    end

    it "routes to #edit" do
      get("/renglon_ndc_articulos/1/edit").should route_to("renglon_ndc_articulos#edit", :id => "1")
    end

    it "routes to #create" do
      post("/renglon_ndc_articulos").should route_to("renglon_ndc_articulos#create")
    end

    it "routes to #update" do
      put("/renglon_ndc_articulos/1").should route_to("renglon_ndc_articulos#update", :id => "1")
    end

    it "routes to #destroy" do
      delete("/renglon_ndc_articulos/1").should route_to("renglon_ndc_articulos#destroy", :id => "1")
    end

  end
end

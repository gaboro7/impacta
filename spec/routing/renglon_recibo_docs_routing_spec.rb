require "spec_helper"

describe RenglonReciboDocsController do
  describe "routing" do

    it "routes to #index" do
      get("/renglon_recibo_docs").should route_to("renglon_recibo_docs#index")
    end

    it "routes to #new" do
      get("/renglon_recibo_docs/new").should route_to("renglon_recibo_docs#new")
    end

    it "routes to #show" do
      get("/renglon_recibo_docs/1").should route_to("renglon_recibo_docs#show", :id => "1")
    end

    it "routes to #edit" do
      get("/renglon_recibo_docs/1/edit").should route_to("renglon_recibo_docs#edit", :id => "1")
    end

    it "routes to #create" do
      post("/renglon_recibo_docs").should route_to("renglon_recibo_docs#create")
    end

    it "routes to #update" do
      put("/renglon_recibo_docs/1").should route_to("renglon_recibo_docs#update", :id => "1")
    end

    it "routes to #destroy" do
      delete("/renglon_recibo_docs/1").should route_to("renglon_recibo_docs#destroy", :id => "1")
    end

  end
end

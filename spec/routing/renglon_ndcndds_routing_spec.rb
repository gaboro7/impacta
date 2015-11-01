require "spec_helper"

describe RenglonNdcnddsController do
  describe "routing" do

    it "routes to #index" do
      get("/renglon_ndcndds").should route_to("renglon_ndcndds#index")
    end

    it "routes to #new" do
      get("/renglon_ndcndds/new").should route_to("renglon_ndcndds#new")
    end

    it "routes to #show" do
      get("/renglon_ndcndds/1").should route_to("renglon_ndcndds#show", :id => "1")
    end

    it "routes to #edit" do
      get("/renglon_ndcndds/1/edit").should route_to("renglon_ndcndds#edit", :id => "1")
    end

    it "routes to #create" do
      post("/renglon_ndcndds").should route_to("renglon_ndcndds#create")
    end

    it "routes to #update" do
      put("/renglon_ndcndds/1").should route_to("renglon_ndcndds#update", :id => "1")
    end

    it "routes to #destroy" do
      delete("/renglon_ndcndds/1").should route_to("renglon_ndcndds#destroy", :id => "1")
    end

  end
end

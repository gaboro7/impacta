require "spec_helper"

describe PromocionsController do
  describe "routing" do

    it "routes to #index" do
      get("/promocions").should route_to("promocions#index")
    end

    it "routes to #new" do
      get("/promocions/new").should route_to("promocions#new")
    end

    it "routes to #show" do
      get("/promocions/1").should route_to("promocions#show", :id => "1")
    end

    it "routes to #edit" do
      get("/promocions/1/edit").should route_to("promocions#edit", :id => "1")
    end

    it "routes to #create" do
      post("/promocions").should route_to("promocions#create")
    end

    it "routes to #update" do
      put("/promocions/1").should route_to("promocions#update", :id => "1")
    end

    it "routes to #destroy" do
      delete("/promocions/1").should route_to("promocions#destroy", :id => "1")
    end

  end
end

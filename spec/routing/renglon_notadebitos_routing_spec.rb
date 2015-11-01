require "spec_helper"

describe RenglonNotadebitosController do
  describe "routing" do

    it "routes to #index" do
      get("/renglon_notadebitos").should route_to("renglon_notadebitos#index")
    end

    it "routes to #new" do
      get("/renglon_notadebitos/new").should route_to("renglon_notadebitos#new")
    end

    it "routes to #show" do
      get("/renglon_notadebitos/1").should route_to("renglon_notadebitos#show", :id => "1")
    end

    it "routes to #edit" do
      get("/renglon_notadebitos/1/edit").should route_to("renglon_notadebitos#edit", :id => "1")
    end

    it "routes to #create" do
      post("/renglon_notadebitos").should route_to("renglon_notadebitos#create")
    end

    it "routes to #update" do
      put("/renglon_notadebitos/1").should route_to("renglon_notadebitos#update", :id => "1")
    end

    it "routes to #destroy" do
      delete("/renglon_notadebitos/1").should route_to("renglon_notadebitos#destroy", :id => "1")
    end

  end
end

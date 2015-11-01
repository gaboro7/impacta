require "spec_helper"

describe NotadedebitosController do
  describe "routing" do

    it "routes to #index" do
      get("/notadedebitos").should route_to("notadedebitos#index")
    end

    it "routes to #new" do
      get("/notadedebitos/new").should route_to("notadedebitos#new")
    end

    it "routes to #show" do
      get("/notadedebitos/1").should route_to("notadedebitos#show", :id => "1")
    end

    it "routes to #edit" do
      get("/notadedebitos/1/edit").should route_to("notadedebitos#edit", :id => "1")
    end

    it "routes to #create" do
      post("/notadedebitos").should route_to("notadedebitos#create")
    end

    it "routes to #update" do
      put("/notadedebitos/1").should route_to("notadedebitos#update", :id => "1")
    end

    it "routes to #destroy" do
      delete("/notadedebitos/1").should route_to("notadedebitos#destroy", :id => "1")
    end

  end
end

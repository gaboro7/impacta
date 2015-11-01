require "spec_helper"

describe ListapreciosController do
  describe "routing" do

    it "routes to #index" do
      get("/listaprecios").should route_to("listaprecios#index")
    end

    it "routes to #new" do
      get("/listaprecios/new").should route_to("listaprecios#new")
    end

    it "routes to #show" do
      get("/listaprecios/1").should route_to("listaprecios#show", :id => "1")
    end

    it "routes to #edit" do
      get("/listaprecios/1/edit").should route_to("listaprecios#edit", :id => "1")
    end

    it "routes to #create" do
      post("/listaprecios").should route_to("listaprecios#create")
    end

    it "routes to #update" do
      put("/listaprecios/1").should route_to("listaprecios#update", :id => "1")
    end

    it "routes to #destroy" do
      delete("/listaprecios/1").should route_to("listaprecios#destroy", :id => "1")
    end

  end
end

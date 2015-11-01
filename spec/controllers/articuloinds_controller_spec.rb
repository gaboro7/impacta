require 'spec_helper'

# This spec was generated by rspec-rails when you ran the scaffold generator.
# It demonstrates how one might use RSpec to specify the controller code that
# was generated by Rails when you ran the scaffold generator.
#
# It assumes that the implementation code is generated by the rails scaffold
# generator.  If you are using any extension libraries to generate different
# controller code, this generated spec may or may not pass.
#
# It only uses APIs available in rails and/or rspec-rails.  There are a number
# of tools you can use to make these specs even more expressive, but we're
# sticking to rails and rspec-rails APIs to keep things simple and stable.
#
# Compared to earlier versions of this generator, there is very limited use of
# stubs and message expectations in this spec.  Stubs are only used when there
# is no simpler way to get a handle on the object needed for the example.
# Message expectations are only used when there is no simpler way to specify
# that an instance is receiving a specific message.

describe ArticuloindsController do

  # This should return the minimal set of attributes required to create a valid
  # Articuloind. As you add validations to Articuloind, be sure to
  # update the return value of this method accordingly.
  def valid_attributes
    {}
  end

  describe "GET index" do
    it "assigns all articuloinds as @articuloinds" do
      articuloind = Articuloind.create! valid_attributes
      get :index
      assigns(:articuloinds).should eq([articuloind])
    end
  end

  describe "GET show" do
    it "assigns the requested articuloind as @articuloind" do
      articuloind = Articuloind.create! valid_attributes
      get :show, :id => articuloind.id
      assigns(:articuloind).should eq(articuloind)
    end
  end

  describe "GET new" do
    it "assigns a new articuloind as @articuloind" do
      get :new
      assigns(:articuloind).should be_a_new(Articuloind)
    end
  end

  describe "GET edit" do
    it "assigns the requested articuloind as @articuloind" do
      articuloind = Articuloind.create! valid_attributes
      get :edit, :id => articuloind.id
      assigns(:articuloind).should eq(articuloind)
    end
  end

  describe "POST create" do
    describe "with valid params" do
      it "creates a new Articuloind" do
        expect {
          post :create, :articuloind => valid_attributes
        }.to change(Articuloind, :count).by(1)
      end

      it "assigns a newly created articuloind as @articuloind" do
        post :create, :articuloind => valid_attributes
        assigns(:articuloind).should be_a(Articuloind)
        assigns(:articuloind).should be_persisted
      end

      it "redirects to the created articuloind" do
        post :create, :articuloind => valid_attributes
        response.should redirect_to(Articuloind.last)
      end
    end

    describe "with invalid params" do
      it "assigns a newly created but unsaved articuloind as @articuloind" do
        # Trigger the behavior that occurs when invalid params are submitted
        Articuloind.any_instance.stub(:save).and_return(false)
        post :create, :articuloind => {}
        assigns(:articuloind).should be_a_new(Articuloind)
      end

      it "re-renders the 'new' template" do
        # Trigger the behavior that occurs when invalid params are submitted
        Articuloind.any_instance.stub(:save).and_return(false)
        post :create, :articuloind => {}
        response.should render_template("new")
      end
    end
  end

  describe "PUT update" do
    describe "with valid params" do
      it "updates the requested articuloind" do
        articuloind = Articuloind.create! valid_attributes
        # Assuming there are no other articuloinds in the database, this
        # specifies that the Articuloind created on the previous line
        # receives the :update_attributes message with whatever params are
        # submitted in the request.
        Articuloind.any_instance.should_receive(:update_attributes).with({'these' => 'params'})
        put :update, :id => articuloind.id, :articuloind => {'these' => 'params'}
      end

      it "assigns the requested articuloind as @articuloind" do
        articuloind = Articuloind.create! valid_attributes
        put :update, :id => articuloind.id, :articuloind => valid_attributes
        assigns(:articuloind).should eq(articuloind)
      end

      it "redirects to the articuloind" do
        articuloind = Articuloind.create! valid_attributes
        put :update, :id => articuloind.id, :articuloind => valid_attributes
        response.should redirect_to(articuloind)
      end
    end

    describe "with invalid params" do
      it "assigns the articuloind as @articuloind" do
        articuloind = Articuloind.create! valid_attributes
        # Trigger the behavior that occurs when invalid params are submitted
        Articuloind.any_instance.stub(:save).and_return(false)
        put :update, :id => articuloind.id, :articuloind => {}
        assigns(:articuloind).should eq(articuloind)
      end

      it "re-renders the 'edit' template" do
        articuloind = Articuloind.create! valid_attributes
        # Trigger the behavior that occurs when invalid params are submitted
        Articuloind.any_instance.stub(:save).and_return(false)
        put :update, :id => articuloind.id, :articuloind => {}
        response.should render_template("edit")
      end
    end
  end

  describe "DELETE destroy" do
    it "destroys the requested articuloind" do
      articuloind = Articuloind.create! valid_attributes
      expect {
        delete :destroy, :id => articuloind.id
      }.to change(Articuloind, :count).by(-1)
    end

    it "redirects to the articuloinds list" do
      articuloind = Articuloind.create! valid_attributes
      delete :destroy, :id => articuloind.id
      response.should redirect_to(articuloinds_url)
    end
  end

end

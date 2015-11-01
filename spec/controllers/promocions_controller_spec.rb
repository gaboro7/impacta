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

describe PromocionsController do

  # This should return the minimal set of attributes required to create a valid
  # Promocion. As you add validations to Promocion, be sure to
  # update the return value of this method accordingly.
  def valid_attributes
    {}
  end

  describe "GET index" do
    it "assigns all promocions as @promocions" do
      promocion = Promocion.create! valid_attributes
      get :index
      assigns(:promocions).should eq([promocion])
    end
  end

  describe "GET show" do
    it "assigns the requested promocion as @promocion" do
      promocion = Promocion.create! valid_attributes
      get :show, :id => promocion.id
      assigns(:promocion).should eq(promocion)
    end
  end

  describe "GET new" do
    it "assigns a new promocion as @promocion" do
      get :new
      assigns(:promocion).should be_a_new(Promocion)
    end
  end

  describe "GET edit" do
    it "assigns the requested promocion as @promocion" do
      promocion = Promocion.create! valid_attributes
      get :edit, :id => promocion.id
      assigns(:promocion).should eq(promocion)
    end
  end

  describe "POST create" do
    describe "with valid params" do
      it "creates a new Promocion" do
        expect {
          post :create, :promocion => valid_attributes
        }.to change(Promocion, :count).by(1)
      end

      it "assigns a newly created promocion as @promocion" do
        post :create, :promocion => valid_attributes
        assigns(:promocion).should be_a(Promocion)
        assigns(:promocion).should be_persisted
      end

      it "redirects to the created promocion" do
        post :create, :promocion => valid_attributes
        response.should redirect_to(Promocion.last)
      end
    end

    describe "with invalid params" do
      it "assigns a newly created but unsaved promocion as @promocion" do
        # Trigger the behavior that occurs when invalid params are submitted
        Promocion.any_instance.stub(:save).and_return(false)
        post :create, :promocion => {}
        assigns(:promocion).should be_a_new(Promocion)
      end

      it "re-renders the 'new' template" do
        # Trigger the behavior that occurs when invalid params are submitted
        Promocion.any_instance.stub(:save).and_return(false)
        post :create, :promocion => {}
        response.should render_template("new")
      end
    end
  end

  describe "PUT update" do
    describe "with valid params" do
      it "updates the requested promocion" do
        promocion = Promocion.create! valid_attributes
        # Assuming there are no other promocions in the database, this
        # specifies that the Promocion created on the previous line
        # receives the :update_attributes message with whatever params are
        # submitted in the request.
        Promocion.any_instance.should_receive(:update_attributes).with({'these' => 'params'})
        put :update, :id => promocion.id, :promocion => {'these' => 'params'}
      end

      it "assigns the requested promocion as @promocion" do
        promocion = Promocion.create! valid_attributes
        put :update, :id => promocion.id, :promocion => valid_attributes
        assigns(:promocion).should eq(promocion)
      end

      it "redirects to the promocion" do
        promocion = Promocion.create! valid_attributes
        put :update, :id => promocion.id, :promocion => valid_attributes
        response.should redirect_to(promocion)
      end
    end

    describe "with invalid params" do
      it "assigns the promocion as @promocion" do
        promocion = Promocion.create! valid_attributes
        # Trigger the behavior that occurs when invalid params are submitted
        Promocion.any_instance.stub(:save).and_return(false)
        put :update, :id => promocion.id, :promocion => {}
        assigns(:promocion).should eq(promocion)
      end

      it "re-renders the 'edit' template" do
        promocion = Promocion.create! valid_attributes
        # Trigger the behavior that occurs when invalid params are submitted
        Promocion.any_instance.stub(:save).and_return(false)
        put :update, :id => promocion.id, :promocion => {}
        response.should render_template("edit")
      end
    end
  end

  describe "DELETE destroy" do
    it "destroys the requested promocion" do
      promocion = Promocion.create! valid_attributes
      expect {
        delete :destroy, :id => promocion.id
      }.to change(Promocion, :count).by(-1)
    end

    it "redirects to the promocions list" do
      promocion = Promocion.create! valid_attributes
      delete :destroy, :id => promocion.id
      response.should redirect_to(promocions_url)
    end
  end

end
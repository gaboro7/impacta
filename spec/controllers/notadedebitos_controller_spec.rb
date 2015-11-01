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

describe NotadedebitosController do

  # This should return the minimal set of attributes required to create a valid
  # Notadedebito. As you add validations to Notadedebito, be sure to
  # update the return value of this method accordingly.
  def valid_attributes
    {}
  end

  describe "GET index" do
    it "assigns all notadedebitos as @notadedebitos" do
      notadedebito = Notadedebito.create! valid_attributes
      get :index
      assigns(:notadedebitos).should eq([notadedebito])
    end
  end

  describe "GET show" do
    it "assigns the requested notadedebito as @notadedebito" do
      notadedebito = Notadedebito.create! valid_attributes
      get :show, :id => notadedebito.id
      assigns(:notadedebito).should eq(notadedebito)
    end
  end

  describe "GET new" do
    it "assigns a new notadedebito as @notadedebito" do
      get :new
      assigns(:notadedebito).should be_a_new(Notadedebito)
    end
  end

  describe "GET edit" do
    it "assigns the requested notadedebito as @notadedebito" do
      notadedebito = Notadedebito.create! valid_attributes
      get :edit, :id => notadedebito.id
      assigns(:notadedebito).should eq(notadedebito)
    end
  end

  describe "POST create" do
    describe "with valid params" do
      it "creates a new Notadedebito" do
        expect {
          post :create, :notadedebito => valid_attributes
        }.to change(Notadedebito, :count).by(1)
      end

      it "assigns a newly created notadedebito as @notadedebito" do
        post :create, :notadedebito => valid_attributes
        assigns(:notadedebito).should be_a(Notadedebito)
        assigns(:notadedebito).should be_persisted
      end

      it "redirects to the created notadedebito" do
        post :create, :notadedebito => valid_attributes
        response.should redirect_to(Notadedebito.last)
      end
    end

    describe "with invalid params" do
      it "assigns a newly created but unsaved notadedebito as @notadedebito" do
        # Trigger the behavior that occurs when invalid params are submitted
        Notadedebito.any_instance.stub(:save).and_return(false)
        post :create, :notadedebito => {}
        assigns(:notadedebito).should be_a_new(Notadedebito)
      end

      it "re-renders the 'new' template" do
        # Trigger the behavior that occurs when invalid params are submitted
        Notadedebito.any_instance.stub(:save).and_return(false)
        post :create, :notadedebito => {}
        response.should render_template("new")
      end
    end
  end

  describe "PUT update" do
    describe "with valid params" do
      it "updates the requested notadedebito" do
        notadedebito = Notadedebito.create! valid_attributes
        # Assuming there are no other notadedebitos in the database, this
        # specifies that the Notadedebito created on the previous line
        # receives the :update_attributes message with whatever params are
        # submitted in the request.
        Notadedebito.any_instance.should_receive(:update_attributes).with({'these' => 'params'})
        put :update, :id => notadedebito.id, :notadedebito => {'these' => 'params'}
      end

      it "assigns the requested notadedebito as @notadedebito" do
        notadedebito = Notadedebito.create! valid_attributes
        put :update, :id => notadedebito.id, :notadedebito => valid_attributes
        assigns(:notadedebito).should eq(notadedebito)
      end

      it "redirects to the notadedebito" do
        notadedebito = Notadedebito.create! valid_attributes
        put :update, :id => notadedebito.id, :notadedebito => valid_attributes
        response.should redirect_to(notadedebito)
      end
    end

    describe "with invalid params" do
      it "assigns the notadedebito as @notadedebito" do
        notadedebito = Notadedebito.create! valid_attributes
        # Trigger the behavior that occurs when invalid params are submitted
        Notadedebito.any_instance.stub(:save).and_return(false)
        put :update, :id => notadedebito.id, :notadedebito => {}
        assigns(:notadedebito).should eq(notadedebito)
      end

      it "re-renders the 'edit' template" do
        notadedebito = Notadedebito.create! valid_attributes
        # Trigger the behavior that occurs when invalid params are submitted
        Notadedebito.any_instance.stub(:save).and_return(false)
        put :update, :id => notadedebito.id, :notadedebito => {}
        response.should render_template("edit")
      end
    end
  end

  describe "DELETE destroy" do
    it "destroys the requested notadedebito" do
      notadedebito = Notadedebito.create! valid_attributes
      expect {
        delete :destroy, :id => notadedebito.id
      }.to change(Notadedebito, :count).by(-1)
    end

    it "redirects to the notadedebitos list" do
      notadedebito = Notadedebito.create! valid_attributes
      delete :destroy, :id => notadedebito.id
      response.should redirect_to(notadedebitos_url)
    end
  end

end

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

describe TelefonosController do

  # This should return the minimal set of attributes required to create a valid
  # Telefono. As you add validations to Telefono, be sure to
  # update the return value of this method accordingly.
  def valid_attributes
    {}
  end

  describe "GET index" do
    it "assigns all telefonos as @telefonos" do
      telefono = Telefono.create! valid_attributes
      get :index
      assigns(:telefonos).should eq([telefono])
    end
  end

  describe "GET show" do
    it "assigns the requested telefono as @telefono" do
      telefono = Telefono.create! valid_attributes
      get :show, :id => telefono.id
      assigns(:telefono).should eq(telefono)
    end
  end

  describe "GET new" do
    it "assigns a new telefono as @telefono" do
      get :new
      assigns(:telefono).should be_a_new(Telefono)
    end
  end

  describe "GET edit" do
    it "assigns the requested telefono as @telefono" do
      telefono = Telefono.create! valid_attributes
      get :edit, :id => telefono.id
      assigns(:telefono).should eq(telefono)
    end
  end

  describe "POST create" do
    describe "with valid params" do
      it "creates a new Telefono" do
        expect {
          post :create, :telefono => valid_attributes
        }.to change(Telefono, :count).by(1)
      end

      it "assigns a newly created telefono as @telefono" do
        post :create, :telefono => valid_attributes
        assigns(:telefono).should be_a(Telefono)
        assigns(:telefono).should be_persisted
      end

      it "redirects to the created telefono" do
        post :create, :telefono => valid_attributes
        response.should redirect_to(Telefono.last)
      end
    end

    describe "with invalid params" do
      it "assigns a newly created but unsaved telefono as @telefono" do
        # Trigger the behavior that occurs when invalid params are submitted
        Telefono.any_instance.stub(:save).and_return(false)
        post :create, :telefono => {}
        assigns(:telefono).should be_a_new(Telefono)
      end

      it "re-renders the 'new' template" do
        # Trigger the behavior that occurs when invalid params are submitted
        Telefono.any_instance.stub(:save).and_return(false)
        post :create, :telefono => {}
        response.should render_template("new")
      end
    end
  end

  describe "PUT update" do
    describe "with valid params" do
      it "updates the requested telefono" do
        telefono = Telefono.create! valid_attributes
        # Assuming there are no other telefonos in the database, this
        # specifies that the Telefono created on the previous line
        # receives the :update_attributes message with whatever params are
        # submitted in the request.
        Telefono.any_instance.should_receive(:update_attributes).with({'these' => 'params'})
        put :update, :id => telefono.id, :telefono => {'these' => 'params'}
      end

      it "assigns the requested telefono as @telefono" do
        telefono = Telefono.create! valid_attributes
        put :update, :id => telefono.id, :telefono => valid_attributes
        assigns(:telefono).should eq(telefono)
      end

      it "redirects to the telefono" do
        telefono = Telefono.create! valid_attributes
        put :update, :id => telefono.id, :telefono => valid_attributes
        response.should redirect_to(telefono)
      end
    end

    describe "with invalid params" do
      it "assigns the telefono as @telefono" do
        telefono = Telefono.create! valid_attributes
        # Trigger the behavior that occurs when invalid params are submitted
        Telefono.any_instance.stub(:save).and_return(false)
        put :update, :id => telefono.id, :telefono => {}
        assigns(:telefono).should eq(telefono)
      end

      it "re-renders the 'edit' template" do
        telefono = Telefono.create! valid_attributes
        # Trigger the behavior that occurs when invalid params are submitted
        Telefono.any_instance.stub(:save).and_return(false)
        put :update, :id => telefono.id, :telefono => {}
        response.should render_template("edit")
      end
    end
  end

  describe "DELETE destroy" do
    it "destroys the requested telefono" do
      telefono = Telefono.create! valid_attributes
      expect {
        delete :destroy, :id => telefono.id
      }.to change(Telefono, :count).by(-1)
    end

    it "redirects to the telefonos list" do
      telefono = Telefono.create! valid_attributes
      delete :destroy, :id => telefono.id
      response.should redirect_to(telefonos_url)
    end
  end

end

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

describe FormadepagosController do

  # This should return the minimal set of attributes required to create a valid
  # Formadepago. As you add validations to Formadepago, be sure to
  # update the return value of this method accordingly.
  def valid_attributes
    {}
  end

  describe "GET index" do
    it "assigns all formadepagos as @formadepagos" do
      formadepago = Formadepago.create! valid_attributes
      get :index
      assigns(:formadepagos).should eq([formadepago])
    end
  end

  describe "GET show" do
    it "assigns the requested formadepago as @formadepago" do
      formadepago = Formadepago.create! valid_attributes
      get :show, :id => formadepago.id
      assigns(:formadepago).should eq(formadepago)
    end
  end

  describe "GET new" do
    it "assigns a new formadepago as @formadepago" do
      get :new
      assigns(:formadepago).should be_a_new(Formadepago)
    end
  end

  describe "GET edit" do
    it "assigns the requested formadepago as @formadepago" do
      formadepago = Formadepago.create! valid_attributes
      get :edit, :id => formadepago.id
      assigns(:formadepago).should eq(formadepago)
    end
  end

  describe "POST create" do
    describe "with valid params" do
      it "creates a new Formadepago" do
        expect {
          post :create, :formadepago => valid_attributes
        }.to change(Formadepago, :count).by(1)
      end

      it "assigns a newly created formadepago as @formadepago" do
        post :create, :formadepago => valid_attributes
        assigns(:formadepago).should be_a(Formadepago)
        assigns(:formadepago).should be_persisted
      end

      it "redirects to the created formadepago" do
        post :create, :formadepago => valid_attributes
        response.should redirect_to(Formadepago.last)
      end
    end

    describe "with invalid params" do
      it "assigns a newly created but unsaved formadepago as @formadepago" do
        # Trigger the behavior that occurs when invalid params are submitted
        Formadepago.any_instance.stub(:save).and_return(false)
        post :create, :formadepago => {}
        assigns(:formadepago).should be_a_new(Formadepago)
      end

      it "re-renders the 'new' template" do
        # Trigger the behavior that occurs when invalid params are submitted
        Formadepago.any_instance.stub(:save).and_return(false)
        post :create, :formadepago => {}
        response.should render_template("new")
      end
    end
  end

  describe "PUT update" do
    describe "with valid params" do
      it "updates the requested formadepago" do
        formadepago = Formadepago.create! valid_attributes
        # Assuming there are no other formadepagos in the database, this
        # specifies that the Formadepago created on the previous line
        # receives the :update_attributes message with whatever params are
        # submitted in the request.
        Formadepago.any_instance.should_receive(:update_attributes).with({'these' => 'params'})
        put :update, :id => formadepago.id, :formadepago => {'these' => 'params'}
      end

      it "assigns the requested formadepago as @formadepago" do
        formadepago = Formadepago.create! valid_attributes
        put :update, :id => formadepago.id, :formadepago => valid_attributes
        assigns(:formadepago).should eq(formadepago)
      end

      it "redirects to the formadepago" do
        formadepago = Formadepago.create! valid_attributes
        put :update, :id => formadepago.id, :formadepago => valid_attributes
        response.should redirect_to(formadepago)
      end
    end

    describe "with invalid params" do
      it "assigns the formadepago as @formadepago" do
        formadepago = Formadepago.create! valid_attributes
        # Trigger the behavior that occurs when invalid params are submitted
        Formadepago.any_instance.stub(:save).and_return(false)
        put :update, :id => formadepago.id, :formadepago => {}
        assigns(:formadepago).should eq(formadepago)
      end

      it "re-renders the 'edit' template" do
        formadepago = Formadepago.create! valid_attributes
        # Trigger the behavior that occurs when invalid params are submitted
        Formadepago.any_instance.stub(:save).and_return(false)
        put :update, :id => formadepago.id, :formadepago => {}
        response.should render_template("edit")
      end
    end
  end

  describe "DELETE destroy" do
    it "destroys the requested formadepago" do
      formadepago = Formadepago.create! valid_attributes
      expect {
        delete :destroy, :id => formadepago.id
      }.to change(Formadepago, :count).by(-1)
    end

    it "redirects to the formadepagos list" do
      formadepago = Formadepago.create! valid_attributes
      delete :destroy, :id => formadepago.id
      response.should redirect_to(formadepagos_url)
    end
  end

end
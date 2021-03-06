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

describe RenglonReciboDocsController do

  # This should return the minimal set of attributes required to create a valid
  # RenglonReciboDoc. As you add validations to RenglonReciboDoc, be sure to
  # update the return value of this method accordingly.
  def valid_attributes
    { "recibo" => "" }
  end

  # This should return the minimal set of values that should be in the session
  # in order to pass any filters (e.g. authentication) defined in
  # RenglonReciboDocsController. Be sure to keep this updated too.
  def valid_session
    {}
  end

  describe "GET index" do
    it "assigns all renglon_recibo_docs as @renglon_recibo_docs" do
      renglon_recibo_doc = RenglonReciboDoc.create! valid_attributes
      get :index, {}, valid_session
      assigns(:renglon_recibo_docs).should eq([renglon_recibo_doc])
    end
  end

  describe "GET show" do
    it "assigns the requested renglon_recibo_doc as @renglon_recibo_doc" do
      renglon_recibo_doc = RenglonReciboDoc.create! valid_attributes
      get :show, {:id => renglon_recibo_doc.to_param}, valid_session
      assigns(:renglon_recibo_doc).should eq(renglon_recibo_doc)
    end
  end

  describe "GET new" do
    it "assigns a new renglon_recibo_doc as @renglon_recibo_doc" do
      get :new, {}, valid_session
      assigns(:renglon_recibo_doc).should be_a_new(RenglonReciboDoc)
    end
  end

  describe "GET edit" do
    it "assigns the requested renglon_recibo_doc as @renglon_recibo_doc" do
      renglon_recibo_doc = RenglonReciboDoc.create! valid_attributes
      get :edit, {:id => renglon_recibo_doc.to_param}, valid_session
      assigns(:renglon_recibo_doc).should eq(renglon_recibo_doc)
    end
  end

  describe "POST create" do
    describe "with valid params" do
      it "creates a new RenglonReciboDoc" do
        expect {
          post :create, {:renglon_recibo_doc => valid_attributes}, valid_session
        }.to change(RenglonReciboDoc, :count).by(1)
      end

      it "assigns a newly created renglon_recibo_doc as @renglon_recibo_doc" do
        post :create, {:renglon_recibo_doc => valid_attributes}, valid_session
        assigns(:renglon_recibo_doc).should be_a(RenglonReciboDoc)
        assigns(:renglon_recibo_doc).should be_persisted
      end

      it "redirects to the created renglon_recibo_doc" do
        post :create, {:renglon_recibo_doc => valid_attributes}, valid_session
        response.should redirect_to(RenglonReciboDoc.last)
      end
    end

    describe "with invalid params" do
      it "assigns a newly created but unsaved renglon_recibo_doc as @renglon_recibo_doc" do
        # Trigger the behavior that occurs when invalid params are submitted
        RenglonReciboDoc.any_instance.stub(:save).and_return(false)
        post :create, {:renglon_recibo_doc => { "recibo" => "invalid value" }}, valid_session
        assigns(:renglon_recibo_doc).should be_a_new(RenglonReciboDoc)
      end

      it "re-renders the 'new' template" do
        # Trigger the behavior that occurs when invalid params are submitted
        RenglonReciboDoc.any_instance.stub(:save).and_return(false)
        post :create, {:renglon_recibo_doc => { "recibo" => "invalid value" }}, valid_session
        response.should render_template("new")
      end
    end
  end

  describe "PUT update" do
    describe "with valid params" do
      it "updates the requested renglon_recibo_doc" do
        renglon_recibo_doc = RenglonReciboDoc.create! valid_attributes
        # Assuming there are no other renglon_recibo_docs in the database, this
        # specifies that the RenglonReciboDoc created on the previous line
        # receives the :update_attributes message with whatever params are
        # submitted in the request.
        RenglonReciboDoc.any_instance.should_receive(:update_attributes).with({ "recibo" => "" })
        put :update, {:id => renglon_recibo_doc.to_param, :renglon_recibo_doc => { "recibo" => "" }}, valid_session
      end

      it "assigns the requested renglon_recibo_doc as @renglon_recibo_doc" do
        renglon_recibo_doc = RenglonReciboDoc.create! valid_attributes
        put :update, {:id => renglon_recibo_doc.to_param, :renglon_recibo_doc => valid_attributes}, valid_session
        assigns(:renglon_recibo_doc).should eq(renglon_recibo_doc)
      end

      it "redirects to the renglon_recibo_doc" do
        renglon_recibo_doc = RenglonReciboDoc.create! valid_attributes
        put :update, {:id => renglon_recibo_doc.to_param, :renglon_recibo_doc => valid_attributes}, valid_session
        response.should redirect_to(renglon_recibo_doc)
      end
    end

    describe "with invalid params" do
      it "assigns the renglon_recibo_doc as @renglon_recibo_doc" do
        renglon_recibo_doc = RenglonReciboDoc.create! valid_attributes
        # Trigger the behavior that occurs when invalid params are submitted
        RenglonReciboDoc.any_instance.stub(:save).and_return(false)
        put :update, {:id => renglon_recibo_doc.to_param, :renglon_recibo_doc => { "recibo" => "invalid value" }}, valid_session
        assigns(:renglon_recibo_doc).should eq(renglon_recibo_doc)
      end

      it "re-renders the 'edit' template" do
        renglon_recibo_doc = RenglonReciboDoc.create! valid_attributes
        # Trigger the behavior that occurs when invalid params are submitted
        RenglonReciboDoc.any_instance.stub(:save).and_return(false)
        put :update, {:id => renglon_recibo_doc.to_param, :renglon_recibo_doc => { "recibo" => "invalid value" }}, valid_session
        response.should render_template("edit")
      end
    end
  end

  describe "DELETE destroy" do
    it "destroys the requested renglon_recibo_doc" do
      renglon_recibo_doc = RenglonReciboDoc.create! valid_attributes
      expect {
        delete :destroy, {:id => renglon_recibo_doc.to_param}, valid_session
      }.to change(RenglonReciboDoc, :count).by(-1)
    end

    it "redirects to the renglon_recibo_docs list" do
      renglon_recibo_doc = RenglonReciboDoc.create! valid_attributes
      delete :destroy, {:id => renglon_recibo_doc.to_param}, valid_session
      response.should redirect_to(renglon_recibo_docs_url)
    end
  end

end

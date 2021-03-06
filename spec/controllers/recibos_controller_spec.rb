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

describe RecibosController do

  # This should return the minimal set of attributes required to create a valid
  # Recibo. As you add validations to Recibo, be sure to
  # update the return value of this method accordingly.
  def valid_attributes
    {}
  end

  describe "GET index" do
    it "assigns all recibos as @recibos" do
      recibo = Recibo.create! valid_attributes
      get :index
      assigns(:recibos).should eq([recibo])
    end
  end

  describe "GET show" do
    it "assigns the requested recibo as @recibo" do
      recibo = Recibo.create! valid_attributes
      get :show, :id => recibo.id
      assigns(:recibo).should eq(recibo)
    end
  end

  describe "GET new" do
    it "assigns a new recibo as @recibo" do
      get :new
      assigns(:recibo).should be_a_new(Recibo)
    end
  end

  describe "GET edit" do
    it "assigns the requested recibo as @recibo" do
      recibo = Recibo.create! valid_attributes
      get :edit, :id => recibo.id
      assigns(:recibo).should eq(recibo)
    end
  end

  describe "POST create" do
    describe "with valid params" do
      it "creates a new Recibo" do
        expect {
          post :create, :recibo => valid_attributes
        }.to change(Recibo, :count).by(1)
      end

      it "assigns a newly created recibo as @recibo" do
        post :create, :recibo => valid_attributes
        assigns(:recibo).should be_a(Recibo)
        assigns(:recibo).should be_persisted
      end

      it "redirects to the created recibo" do
        post :create, :recibo => valid_attributes
        response.should redirect_to(Recibo.last)
      end
    end

    describe "with invalid params" do
      it "assigns a newly created but unsaved recibo as @recibo" do
        # Trigger the behavior that occurs when invalid params are submitted
        Recibo.any_instance.stub(:save).and_return(false)
        post :create, :recibo => {}
        assigns(:recibo).should be_a_new(Recibo)
      end

      it "re-renders the 'new' template" do
        # Trigger the behavior that occurs when invalid params are submitted
        Recibo.any_instance.stub(:save).and_return(false)
        post :create, :recibo => {}
        response.should render_template("new")
      end
    end
  end

  describe "PUT update" do
    describe "with valid params" do
      it "updates the requested recibo" do
        recibo = Recibo.create! valid_attributes
        # Assuming there are no other recibos in the database, this
        # specifies that the Recibo created on the previous line
        # receives the :update_attributes message with whatever params are
        # submitted in the request.
        Recibo.any_instance.should_receive(:update_attributes).with({'these' => 'params'})
        put :update, :id => recibo.id, :recibo => {'these' => 'params'}
      end

      it "assigns the requested recibo as @recibo" do
        recibo = Recibo.create! valid_attributes
        put :update, :id => recibo.id, :recibo => valid_attributes
        assigns(:recibo).should eq(recibo)
      end

      it "redirects to the recibo" do
        recibo = Recibo.create! valid_attributes
        put :update, :id => recibo.id, :recibo => valid_attributes
        response.should redirect_to(recibo)
      end
    end

    describe "with invalid params" do
      it "assigns the recibo as @recibo" do
        recibo = Recibo.create! valid_attributes
        # Trigger the behavior that occurs when invalid params are submitted
        Recibo.any_instance.stub(:save).and_return(false)
        put :update, :id => recibo.id, :recibo => {}
        assigns(:recibo).should eq(recibo)
      end

      it "re-renders the 'edit' template" do
        recibo = Recibo.create! valid_attributes
        # Trigger the behavior that occurs when invalid params are submitted
        Recibo.any_instance.stub(:save).and_return(false)
        put :update, :id => recibo.id, :recibo => {}
        response.should render_template("edit")
      end
    end
  end

  describe "DELETE destroy" do
    it "destroys the requested recibo" do
      recibo = Recibo.create! valid_attributes
      expect {
        delete :destroy, :id => recibo.id
      }.to change(Recibo, :count).by(-1)
    end

    it "redirects to the recibos list" do
      recibo = Recibo.create! valid_attributes
      delete :destroy, :id => recibo.id
      response.should redirect_to(recibos_url)
    end
  end

end

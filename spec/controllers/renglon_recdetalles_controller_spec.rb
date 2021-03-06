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

describe RenglonRecdetallesController do

  # This should return the minimal set of attributes required to create a valid
  # RenglonRecdetalle. As you add validations to RenglonRecdetalle, be sure to
  # update the return value of this method accordingly.
  def valid_attributes
    {}
  end

  describe "GET index" do
    it "assigns all renglon_recdetalles as @renglon_recdetalles" do
      renglon_recdetalle = RenglonRecdetalle.create! valid_attributes
      get :index
      assigns(:renglon_recdetalles).should eq([renglon_recdetalle])
    end
  end

  describe "GET show" do
    it "assigns the requested renglon_recdetalle as @renglon_recdetalle" do
      renglon_recdetalle = RenglonRecdetalle.create! valid_attributes
      get :show, :id => renglon_recdetalle.id
      assigns(:renglon_recdetalle).should eq(renglon_recdetalle)
    end
  end

  describe "GET new" do
    it "assigns a new renglon_recdetalle as @renglon_recdetalle" do
      get :new
      assigns(:renglon_recdetalle).should be_a_new(RenglonRecdetalle)
    end
  end

  describe "GET edit" do
    it "assigns the requested renglon_recdetalle as @renglon_recdetalle" do
      renglon_recdetalle = RenglonRecdetalle.create! valid_attributes
      get :edit, :id => renglon_recdetalle.id
      assigns(:renglon_recdetalle).should eq(renglon_recdetalle)
    end
  end

  describe "POST create" do
    describe "with valid params" do
      it "creates a new RenglonRecdetalle" do
        expect {
          post :create, :renglon_recdetalle => valid_attributes
        }.to change(RenglonRecdetalle, :count).by(1)
      end

      it "assigns a newly created renglon_recdetalle as @renglon_recdetalle" do
        post :create, :renglon_recdetalle => valid_attributes
        assigns(:renglon_recdetalle).should be_a(RenglonRecdetalle)
        assigns(:renglon_recdetalle).should be_persisted
      end

      it "redirects to the created renglon_recdetalle" do
        post :create, :renglon_recdetalle => valid_attributes
        response.should redirect_to(RenglonRecdetalle.last)
      end
    end

    describe "with invalid params" do
      it "assigns a newly created but unsaved renglon_recdetalle as @renglon_recdetalle" do
        # Trigger the behavior that occurs when invalid params are submitted
        RenglonRecdetalle.any_instance.stub(:save).and_return(false)
        post :create, :renglon_recdetalle => {}
        assigns(:renglon_recdetalle).should be_a_new(RenglonRecdetalle)
      end

      it "re-renders the 'new' template" do
        # Trigger the behavior that occurs when invalid params are submitted
        RenglonRecdetalle.any_instance.stub(:save).and_return(false)
        post :create, :renglon_recdetalle => {}
        response.should render_template("new")
      end
    end
  end

  describe "PUT update" do
    describe "with valid params" do
      it "updates the requested renglon_recdetalle" do
        renglon_recdetalle = RenglonRecdetalle.create! valid_attributes
        # Assuming there are no other renglon_recdetalles in the database, this
        # specifies that the RenglonRecdetalle created on the previous line
        # receives the :update_attributes message with whatever params are
        # submitted in the request.
        RenglonRecdetalle.any_instance.should_receive(:update_attributes).with({'these' => 'params'})
        put :update, :id => renglon_recdetalle.id, :renglon_recdetalle => {'these' => 'params'}
      end

      it "assigns the requested renglon_recdetalle as @renglon_recdetalle" do
        renglon_recdetalle = RenglonRecdetalle.create! valid_attributes
        put :update, :id => renglon_recdetalle.id, :renglon_recdetalle => valid_attributes
        assigns(:renglon_recdetalle).should eq(renglon_recdetalle)
      end

      it "redirects to the renglon_recdetalle" do
        renglon_recdetalle = RenglonRecdetalle.create! valid_attributes
        put :update, :id => renglon_recdetalle.id, :renglon_recdetalle => valid_attributes
        response.should redirect_to(renglon_recdetalle)
      end
    end

    describe "with invalid params" do
      it "assigns the renglon_recdetalle as @renglon_recdetalle" do
        renglon_recdetalle = RenglonRecdetalle.create! valid_attributes
        # Trigger the behavior that occurs when invalid params are submitted
        RenglonRecdetalle.any_instance.stub(:save).and_return(false)
        put :update, :id => renglon_recdetalle.id, :renglon_recdetalle => {}
        assigns(:renglon_recdetalle).should eq(renglon_recdetalle)
      end

      it "re-renders the 'edit' template" do
        renglon_recdetalle = RenglonRecdetalle.create! valid_attributes
        # Trigger the behavior that occurs when invalid params are submitted
        RenglonRecdetalle.any_instance.stub(:save).and_return(false)
        put :update, :id => renglon_recdetalle.id, :renglon_recdetalle => {}
        response.should render_template("edit")
      end
    end
  end

  describe "DELETE destroy" do
    it "destroys the requested renglon_recdetalle" do
      renglon_recdetalle = RenglonRecdetalle.create! valid_attributes
      expect {
        delete :destroy, :id => renglon_recdetalle.id
      }.to change(RenglonRecdetalle, :count).by(-1)
    end

    it "redirects to the renglon_recdetalles list" do
      renglon_recdetalle = RenglonRecdetalle.create! valid_attributes
      delete :destroy, :id => renglon_recdetalle.id
      response.should redirect_to(renglon_recdetalles_url)
    end
  end

end

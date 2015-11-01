class RenglonNdcdetallesController < ApplicationController

  before_filter :authenticate

  # GET /renglon_ndcdetalles
  # GET /renglon_ndcdetalles.json
  def index
    @notadecredito = Notadecredito.find(params[:notadecredito_id])
    @renglon_ndcdetalles = @notadecredito.renglon_ndcdetalles

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @renglon_ndcdetalles }
    end
  end

  # GET /renglon_ndcdetalles/1
  # GET /renglon_ndcdetalles/1.json
  def show
    @notadecredito = Notadecredito.find(params[:notadecredito_id])
    @renglon_ndcdetalle = @notadecredito.renglon_ndcdetalles.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @renglon_ndcdetalle }
    end
  end

  # GET /renglon_ndcdetalles/new
  # GET /renglon_ndcdetalles/new.json
  def new
    @renglon_ndcdetalle = RenglonNdcdetalle.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @renglon_ndcdetalle }
    end
  end

  # GET /renglon_ndcdetalles/1/edit
  def edit
    @notadecredito = Notadecredito.find(params[:notadecredito_id])
    @renglon_ndcdetalle = @notadecredito.renglon_ndcdetalles.find(params[:id])
    respond_to do |format|
      format.html { render :layout => 'special_form'}# new.html.erb
    end
  end

  # POST /renglon_ndcdetalles
  # POST /renglon_ndcdetalles.json
  def create

    @notadecredito = Notadecredito.find(params[:notadecredito_id])
    @renglon_ndcdetalle = @notadecredito.renglon_ndcdetalles.create(params[:renglon_ndcdetalle])

    respond_to do |format|
      if @renglon_ndcdetalle.save
        format.html { redirect_to @notadecredito, notice: 'Renglon ndcdetalle was successfully created.' }
        format.json { render json: @renglon_ndcdetalle}
      else
        format.html { render action: "new" }
        format.json { render json: @renglon_ndcdetalle.errors}
      end
    end
  end

  # PUT /renglon_ndcdetalles/1
  # PUT /renglon_ndcdetalles/1.json
  def update
    @notadecredito = Notadecredito.find(params[:notadecredito_id])
    @renglon_ndcdetalle = @notadecredito.renglon_ndcdetalles.find(params[:id])

    respond_to do |format|
      if @renglon_ndcdetalle.update_attributes(params[:renglon_ndcdetalle])
        format.html { redirect_to @renglon_ndcdetalle, notice: 'Renglon ndcdetalle was successfully updated.' }
        format.json { render json: @renglon_ndcdetalle }
      else
        format.html { render action: "edit" }
        format.json { render json: @renglon_ndcdetalle.errors}
      end
    end
  end

  # DELETE /renglon_ndcdetalles/1
  # DELETE /renglon_ndcdetalles/1.json
  def destroy
    @notadecredito = Notadecredito.find(params[:notadecredito_id])
    @renglon_ndcdetalle = @notadecredito.renglon_ndcdetalles.find(params[:id]).destroy

    respond_to do |format|
      format.html { redirect_to @notadecredito_url }
      format.json { head :ok }
    end
  end
end

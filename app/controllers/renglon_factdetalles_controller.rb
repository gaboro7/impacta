class RenglonFactdetallesController < ApplicationController

  before_filter :authenticate

  # GET /renglon_factdetalles
  # GET /renglon_factdetalles.json
  def index
    @factura = Factura.find(params[:factura_id])
    @renglon_factdetalles = @factura.renglon_factdetalles.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @renglon_factdetalles }
    end
  end

  # GET /renglon_factdetalles/1
  # GET /renglon_factdetalles/1.json
  def show
    @factura = Factura.find(params[:factura_id])
    @renglon_factdetalle = @factura.renglon_factdetalles.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @renglon_factdetalle }
    end
  end

  # GET /renglon_factdetalles/new
  # GET /renglon_factdetalles/new.json
  def new
    @renglon_factdetalle = RenglonFactdetalle.new

    respond_to do |format|
       format.html { render :layout => 'special_form'}# new.html.erb
      format.json { render json: @renglon_factdetalle }
    end
  end

  # GET /renglon_factdetalles/1/edit
  def edit
    @factura = Factura.find(params[:factura_id])
    @renglon_factdetalle = @factura.renglon_factdetalles.find(params[:id])
     respond_to do |format|
      format.html { render :layout => 'special_form'}# new.html.erb
       format.json { render json: @renglon_factdetalle }
    end
  end

  # POST /renglon_factdetalles
  # POST /renglon_factdetalles.json
  def create
    @factura = Factura.find(params[:factura_id])
    @renglon_factdetalle = RenglonFactdetalle.new(params[:renglon_factdetalle])
    @factura.renglon_factdetalles << @renglon_factdetalle

    respond_to do |format|
      if @factura.save
        format.html { redirect_to @factura, notice: 'Renglon factdetalle was successfully created.' }
        format.json { render json: @renglon_factdetalle}
      else
        format.html { render action: "new" }
        format.json { render json: @renglon_factdetalle.errors }
      end
    end
  end

  # PUT /renglon_factdetalles/1
  # PUT /renglon_factdetalles/1.json
  def update
    @factura = Factura.find(params[:factura_id])
    @renglon_factdetalle = @factura.renglon_factdetalles.find(params[:id])

    if (params[:renglon_factdetalle][:impuesto_ids] == nil)
      params[:renglon_factdetalle][:impuesto_ids] = []
    end

    respond_to do |format|
      if @renglon_factdetalle.update_attributes(params[:renglon_factdetalle])
        format.html { redirect_to @factura, notice: 'Renglon factdetalle was successfully updated.' }
        format.json { render json: @renglon_factdetalle }
      else
        format.html { render action: "edit" }
        format.json { render json: @renglon_factdetalle.errors }
      end
    end
  end

  # DELETE /renglon_factdetalles/1
  # DELETE /renglon_factdetalles/1.json
  def destroy
    @factura = Factura.find(params[:factura_id])
    @renglon_factdetalle = @factura.renglon_factdetalles.find(params[:id]).destroy

    respond_to do |format|
      format.html { head :ok }
      format.json { head :ok }
    end
  end
end

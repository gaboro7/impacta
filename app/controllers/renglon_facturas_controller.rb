class RenglonFacturasController < ApplicationController

  before_filter :authenticate

  # GET /renglon_facturas
  # GET /renglon_facturas.json
  def index
    @factura = Factura.find(params[:factura_id])
    @renglon_facturas = @factura.renglon_facturas

    respond_to do |format|
      format.html # index.html.erb
      #format.json { render json: @renglon_facturas }
    end
  end

  # GET /renglon_facturas/1
  # GET /renglon_facturas/1.json
  def show
    @factura = Factura.find(params[:factura_id])
    @renglon_factura = @factura.renglon_facturas.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      #format.json { render json: @renglon_factura }
    end
  end

  # GET /renglon_facturas/new
  # GET /renglon_facturas/new.json
  def new
    @renglon_factura = RenglonFactura.new

    respond_to do |format|
      format.html # new.html.erb
      #format.json { render json: @renglon_factura }
    end
  end

  # GET /renglon_facturas/1/edit
  def edit
    @factura = Factura.find(params[:factura_id])
    @renglon_factura = @factura.renglon_facturas.find(params[:id])
    respond_to do |format|
      format.html { render :layout => 'special_form'}# new.html.erb
    end
  end

  # POST /renglon_facturas
  # POST /renglon_facturas.json
  def create
    @factura = Factura.find(params[:factura_id])
    @renglon_factura = @factura.renglon_facturas.build(params[:renglon_factura])
    #@factura.renglon_facturas << @renglon_factura

    respond_to do |format|
      if @renglon_factura.save
        format.html { redirect_to @factura, :notice => 'Renglon factura was successfully created.' }
        format.json { render json: @renglon_factura }
      else
        format.html { render :action => "new" }
        format.json { render json: @renglon_factura.errors }
        #@renglon_factura.delete()
      end
    end
  end

  # PUT /renglon_facturas/1
  # PUT /renglon_facturas/1.json
  def update
    @factura = Factura.find(params[:factura_id])
    @renglon_factura = @factura.renglon_facturas.find(params[:id])

    respond_to do |format|
      if @renglon_factura.update_attributes(params[:renglon_factura])
        format.html { redirect_to @factura, :notice => 'Renglon factura was successfully updated.' }
        format.json { render json: @renglon_factura }
      else
        format.html { render :action => "edit" }
        format.json { render json: @renglon_factura.errors }
      end
    end
  end

  # DELETE /renglon_facturas/1
  # DELETE /renglon_facturas/1.json
  def destroy
    @factura = Factura.find(params[:factura_id])
    @renglon_factura = @factura.renglon_facturas.find(params[:id]).destroy

    respond_to do |format|
      format.html { head :ok }
      #format.json { head :ok }
    end
  end
end

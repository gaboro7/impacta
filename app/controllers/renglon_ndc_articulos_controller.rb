class RenglonNdcArticulosController < ApplicationController

  before_filter :authenticate

  # GET /renglon_ndc_articulos
  # GET /renglon_ndc_articulos.json
  def index

    @notadecredito = Notadecredito.find(params[:notadecredito_id])
    @renglon_ndc_articulos = @notadecredito.renglon_ndc_articulos

    respond_to do |format|
      format.html # index.html.erb
    end
  end

  # GET /renglon_ndc_articulos/1
  # GET /renglon_ndc_articulos/1.json
  def show

    @notadecredito = Notadecredito.find(params[:notadecredito_id])
    @renglon_ndc_articulo = @notadecredito.renglon_ndc_articulos.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
    end
  end

  # GET /renglon_ndc_articulos/new
  # GET /renglon_ndc_articulos/new.json
  def new
    @renglon_ndc_articulo = RenglonNdcArticulo.new

    respond_to do |format|
      format.html # new.html.erb
      #format.json { render json: @renglon_ndc_articulo }
    end
  end

  # GET /renglon_ndc_articulos/1/edit
  def edit

    @notadecredito = Notadecredito.find(params[:notadecredito_id])
    @renglon_ndc_articulo = @notadecredito.renglon_ndc_articulos.find(params[:id])

    respond_to do |format|
      format.html { render :layout => 'special_form'}# new.html.erb
    end
  end

  # POST /renglon_ndc_articulos
  # POST /renglon_ndc_articulos.json
  def create


    @notadecredito = Notadecredito.find(params[:notadecredito_id])
    @renglon_ndc_articulo = @notadecredito.renglon_ndc_articulos.build(params[:renglon_ndc_articulo])

    respond_to do |format|
      if @renglon_ndc_articulo.save
        format.html { redirect_to @notadecredito, :notice => 'Renglon NDC Articulo was successfully created.' }
        format.json { render json: @renglon_ndc_articulo }
      else
        format.html { render :action => "new" }
        format.json { render json: @renglon_ndc_articulo.errors }

      end
    end

  end

  # PUT /renglon_ndc_articulos/1
  # PUT /renglon_ndc_articulos/1.json
  def update
    @notadecredito = Notadecredito.find(params[:notadecredito_id])
    @renglon_ndc_articulo = @notadecredito.renglon_ndc_articulos.find(params[:id])

    respond_to do |format|
      if @renglon_ndc_articulo.update_attributes(params[:renglon_ndc_articulo])
        format.html { redirect_to @notadecredito, :notice => 'Renglon NDC Articulo was successfully updated.' }
        format.json { render json: @renglon_ndc_articulo }
      else
        format.html { render :action => "edit" }
        format.json { render json: @renglon_ndc_articulo.errors }
      end
    end

  end

  # DELETE /renglon_ndc_articulos/1
  # DELETE /renglon_ndc_articulos/1.json
  def destroy
    @notadecredito = Notadecredito.find(params[:notadecredito_id])
    @renglon_ndc_articulo = @notadecredito.renglon_ndc_articulos.find(params[:id]).destroy

    respond_to do |format|
      format.html { head :ok }
      #format.json { head :ok }
    end
  end
end

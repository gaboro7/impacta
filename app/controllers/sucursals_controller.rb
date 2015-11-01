class SucursalsController < ApplicationController

  before_filter :authenticate

  # GET /sucursals
  # GET /sucursals.json
  def index
    @empresa = Empresa.find(params[:empresa_id])
    @sucursals = @empresa.sucursals

    respond_to do |format|
      format.html # index.html.erb
      #format.json { render json: @sucursals }
    end
  end

  # GET /sucursals/1
  # GET /sucursals/1.json
  def show
    @empresa = Empresa.find(params[:empresa_id])
    @sucursal = @empresa.sucursals.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      #format.json { render json: @sucursal }
    end
  end

  # GET /sucursals/new
  # GET /sucursals/new.json
  def new
    @sucursal = Sucursal.new

    respond_to do |format|
      format.html # new.html.erb
      #format.json { render json: @sucursal }
    end
  end

  # GET /sucursals/1/edit
  def edit
    @empresa = Empresa.find(params[:empresa_id])
    @sucursal = @empresa.sucursals.find(params[:id])
    respond_to do |format|
      format.html {  render :layout => false}# new.html.erb
      #format.json { render json: @empresa }
    end
  end

  # POST /sucursals
  # POST /sucursals.json
  def create
    @empresa = Empresa.find(params[:empresa_id])
    @sucursal = Sucursal.new(params[:sucursal])
    @empresa.sucursals << @sucursal

    respond_to do |format|
      if @sucursal.save
        format.html { redirect_to @empresa, :notice => 'La sucursal fue creada satisfactoriamente' }
        format.json { render json: @sucursal }
      else
        format.html { render :action => "new" }
        format.json { render json: @sucursal.errors}
      end
    end
  end

  # PUT /sucursals/1
  # PUT /sucursals/1.json
  def update
    @empresa = Empresa.find(params[:empresa_id])

    respond_to do |format|
      if @empresa.sucursals.find(params[:id]).update_attributes(params[:sucursal])
        format.html { redirect_to @empresa, :notice => 'La sucursal fue actualizada satisfactoriamente' }
        format.json { render json: @sucursal }
      else
        format.html { render :action => "edit" }
        format.json { render json: @sucursal.errors}
      end
    end
  end

  # DELETE /sucursals/1
  # DELETE /sucursals/1.json
  def destroy
    @empresa = Empresa.find(params[:empresa_id])
    @sucursal = @empresa.sucursals.find(params[:id]).destroy

    respond_to do |format|
      format.html { redirect_to @empresa }
      #format.json { head :ok }
    end
  end
end

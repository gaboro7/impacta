class PagocontadosController < ApplicationController

  before_filter :authenticate

  # GET /pagocontados
  # GET /pagocontados.json
  def index
    @pagocontados = Pagocontado.paginate(:page => params[:numero_hoja], :per_page => 18)
    if params[:numero_hoja].nil?

      respond_to do |format|
        format.html # index.html.erb
        #format.json { render json: @pagocontados }
      end
    else
      respond_to do |format|
        format.html  { render :layout => "application_paginate"}# index.html.erb
        #format.json { render json: @impuestos }
      end
    end
  end

  # GET /pagocontados/1
  # GET /pagocontados/1.json
  def show
    @pagocontado = Pagocontado.find(params[:id])

    respond_to do |format|
      format.html { render :layout => 'special_form'}# new.html.erb
      format.json { render json: @pagocontado, :include => :moneda }
    end
  end

  # GET /pagocontados/new
  # GET /pagocontados/new.json
  def new
    @pagocontado = Pagocontado.new

    respond_to do |format|
      format.html { render :layout => 'special_form'}# new.html.erb
      #format.json { render json: @pagocontado }
    end
  end

  # GET /pagocontados/1/edit
  def edit
    @pagocontado = Pagocontado.find(params[:id])
    respond_to do |format|
      format.html { render :layout => 'special_form'}# new.html.erb
      format.json { render json: @pagoacredito }
    end
  end

  # POST /pagocontados
  # POST /pagocontados.json
  def create
    @pagocontado = Pagocontado.new(params[:pagocontado])

    respond_to do |format|
      if @pagocontado.save
        format.html { redirect_to @pagocontado, :notice => 'Pagocontado was successfully created.' }
        format.json { render json: @pagocontado, status: :created, location: @pagocontado }
      else
        format.html { render :action => "new" }
        format.json { render json: @pagocontado.errors }
      end
    end
  end

  # PUT /pagocontados/1
  # PUT /pagocontados/1.json
  def update
    @pagocontado = Pagocontado.find(params[:id])


    if (params[:pagocontado][:moneda_ids] == nil)
      params[:pagocontado][:moneda_ids] = []
    end


    respond_to do |format|
      if @pagocontado.update_attributes(params[:pagocontado])
        format.html { redirect_to @pagocontado, :notice => 'Pagocontado was successfully updated.' }
        format.json { render json: @pagocontado }
      else
        format.html { render :action => "edit" }
        format.json { render json: @pagocontado.errors }
      end
    end
  end

  # DELETE /pagocontados/1
  # DELETE /pagocontados/1.json
  def destroy
    @pagocontado = Pagocontado.find(params[:id])
    @pagocontado.destroy

    respond_to do |format|
      format.html { redirect_to pagocontados_url }
      #format.json { head :ok }
    end
  end
end

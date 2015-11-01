class ImpuestosController < ApplicationController

  before_filter :authenticate

  # GET /impuestos
  # GET /impuestos.json
  def index
    @impuestos = Impuesto.paginate(:page => params[:numero_hoja], :per_page => 18)
    if params[:numero_hoja].nil?
      respond_to do |format|
        format.html # index.html.erb
        #format.json { render json: @impuestos }
      end
    else
       respond_to do |format|
        format.html  { render :layout => "application_paginate"}# index.html.erb
        #format.json { render json: @impuestos }
      end
    end
  end

  # GET /impuestos/1
  # GET /impuestos/1.json
  def show
    @impuesto = Impuesto.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      #format.json { render json: @impuesto }
    end
  end

  # GET /impuestos/new
  # GET /impuestos/new.json
  def new
    @impuesto = Impuesto.new

    respond_to do |format|
      format.html { render :layout => 'special_form'}# new.html.erb
      #format.json { render json: @impuesto }
    end
  end

  # GET /impuestos/1/edit
  def edit
    @impuesto = Impuesto.find(params[:id])
    respond_to do |format|
      format.html { render :layout => 'special_form'}# new.html.erb
      #format.json { render json: @impuesto }
    end
  end

  # POST /impuestos
  # POST /impuestos.json
  def create
    @impuesto = Impuesto.new(params[:impuesto])

    respond_to do |format|
      if @impuesto.save
        format.html { redirect_to @impuesto, :notice => 'Impuesto was successfully created.' }
        format.json { render json: @impuesto, status: :created, location: @impuesto }
      else
        format.html { render :action => "new" }
        format.json { render json: @impuesto.errors }
      end
    end
  end

  # PUT /impuestos/1
  # PUT /impuestos/1.json
  def update
    @impuesto = Impuesto.find(params[:id])

    respond_to do |format|
      if @impuesto.update_attributes(params[:impuesto])
        format.html { redirect_to @impuesto, :notice => 'Impuesto was successfully updated.' }
        format.json { render json: @impuesto }
      else
        format.html { render :action => "edit" }
        format.json { render json: @impuesto.errors }
      end
    end
  end

  # DELETE /impuestos/1
  # DELETE /impuestos/1.json
  def destroy
    @impuesto = Impuesto.find(params[:id])
    @impuesto.destroy

    respond_to do |format|
      format.html { redirect_to impuestos_url }
      #format.json { head :ok }
    end
  end
end

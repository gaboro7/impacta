class TipoclientesController < ApplicationController

  before_filter :authenticate

  # GET /tipoclientes
  # GET /tipoclientes.json
  def index
    @tipoclientes = Tipocliente.paginate(:page => params[:numero_hoja], :per_page => 18)
    if params[:numero_hoja].nil?

      respond_to do |format|
        format.html # index.html.erb
        #format.json { render json: @tipoclientes }
      end
    else
      respond_to do |format|
        format.html  { render :layout => "application_paginate"}# index.html.erb
        #format.json { render json: @impuestos }
      end
    end
  end
  # GET /tipoclientes/1
  # GET /tipoclientes/1.json
  def show
    @tipocliente = Tipocliente.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      #format.json { render json: @tipocliente }
    end
  end

  # GET /tipoclientes/new
  # GET /tipoclientes/new.json
  def new
    @tipocliente = Tipocliente.new

    respond_to do |format|
      format.html { render :layout => 'special_form'}# new.html.erb
      #format.json { render json: @tipocliente }
    end
  end

  # GET /tipoclientes/1/edit
  def edit
    @tipocliente = Tipocliente.find(params[:id])
    respond_to do |format|
      format.html { render :layout => 'special_form'}# new.html.erb
      #format.json { render json: @tipocliente }
    end
  end

  # POST /tipoclientes
  # POST /tipoclientes.json
  def create
    @tipocliente = Tipocliente.new(params[:tipocliente])

    respond_to do |format|
      if @tipocliente.save
        format.html { redirect_to @tipocliente, :notice => 'Tipocliente was successfully created.' }
        format.json { render json: @tipocliente, status: :created }
      else
        format.html { render :action => "new" }
        format.json { render json: @tipocliente.errors }
      end
    end
  end

  # PUT /tipoclientes/1
  # PUT /tipoclientes/1.json
  def update
    @tipocliente = Tipocliente.find(params[:id])

    respond_to do |format|
      if @tipocliente.update_attributes(params[:tipocliente])
        format.html { redirect_to @tipocliente, :notice => 'Tipocliente was successfully updated.' }
        format.json { render json: @tipocliente }
      else
        format.html { render :action => "edit" }
        format.json { render json: @tipocliente.errors }
      end
    end
  end

  # DELETE /tipoclientes/1
  # DELETE /tipoclientes/1.json
  def destroy
    @tipocliente = Tipocliente.find(params[:id])
    @tipocliente.destroy

    respond_to do |format|
      format.html { redirect_to tipoclientes_url }
      #format.json { head :ok }
    end
  end
end

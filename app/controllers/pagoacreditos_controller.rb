class PagoacreditosController < ApplicationController

  before_filter :authenticate

  # GET /pagoacreditos
  # GET /pagoacreditos.json
  def index
    @pagoacreditos = Pagoacredito.paginate(:page => params[:numero_hoja], :per_page => 18)
    if params[:numero_hoja].nil?

      respond_to do |format|
        format.html # index.html.erb
        #format.json { render json: @pagoacreditos }
      end
    else
      respond_to do |format|
        format.html  { render :layout => "application_paginate"}# index.html.erb
        #format.json { render json: @impuestos }
      end
    end
  end

  # GET /pagoacreditos/1
  # GET /pagoacreditos/1.json
  def show
    @pagoacredito = Pagoacredito.find(params[:id])

    respond_to do |format|
      format.html { render :layout => 'special_form'}# new.html.erb
      format.json { render json: @pagoacredito , :include => :moneda }
    end
  end

  # GET /pagoacreditos/new
  # GET /pagoacreditos/new.json
  def new
    @pagoacredito = Pagoacredito.new

    respond_to do |format|
      format.html { render :layout => 'special_form'}# new.html.erb
      #format.json { render json: @pagoacredito }
    end
  end

  # GET /pagoacreditos/1/edit
  def edit
    @pagoacredito = Pagoacredito.find(params[:id])
    respond_to do |format|
      format.html { render :layout => 'special_form'}# new.html.erb
      #format.json { render json: @pagoacredito }
    end
  end

  # POST /pagoacreditos
  # POST /pagoacreditos.json
  def create
    @pagoacredito = Pagoacredito.new(params[:pagoacredito])

    respond_to do |format|
      if @pagoacredito.save
        format.html { redirect_to @pagoacredito, :notice => 'Pagoacredito was successfully created.' }
        format.json { render json: @pagoacredito, status: :created, location: @pagoacredito }
      else
        format.html { render :action => "new" }
        format.json { render json: @pagoacredito.errors }
      end
    end
  end

  # PUT /pagoacreditos/1
  # PUT /pagoacreditos/1.json
  def update
    @pagoacredito = Pagoacredito.find(params[:id])


    if (params[:pagoacredito][:moneda_ids] == nil)
      params[:pagoacredito][:moneda_ids] = []
    end


    respond_to do |format|
      if @pagoacredito.update_attributes(params[:pagoacredito])
        format.html { redirect_to @pagoacredito, :notice => 'Pagoacredito was successfully updated.' }
        format.json { render json: @pagoacredito }
      else
        format.html { render :action => "edit" }
        format.json { render json: @pagoacredito.errors}
      end
    end
  end

  # DELETE /pagoacreditos/1
  # DELETE /pagoacreditos/1.json
  def destroy
    @pagoacredito = Pagoacredito.find(params[:id])
    @pagoacredito.destroy

    respond_to do |format|
      format.html { redirect_to pagoacreditos_url }
      #format.json { head :ok }
    end
  end
end

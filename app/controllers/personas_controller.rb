class PersonasController < ApplicationController

  before_filter :authenticate

  # GET /personas
  # GET /personas.json
  def index
    if params[:filtro] != nil
      @personas = Persona.where("nombre like '%" +params[:filtro] +"%' or id like '%" +params[:filtro] +"%'")
    else
      @personas = Persona.paginate(:page => params[:numero_hoja], :per_page => 18)
    end
    if params[:numero_hoja].nil?
      respond_to do |format|
        format.html # index.html.erb
        format.json { render json: @personas }
      end
    else
      respond_to do |format|
        format.html  { render :layout => "application_paginate"}# index.html.erb
        #format.json { render json: @impuestos }
      end
    end
  end

  # GET /personas/1
  # GET /personas/1.json
  def show
    @persona = Persona.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      #format.json { render json: @persona }
    end
  end

  # GET /personas/new
  # GET /personas/new.json
  def new
    @persona = Persona.new
    respond_to do |format|
      format.html { render :layout => 'special_form'}# new.html.erb
      format.json { render json: @persona }
    end
  end

  # GET /personas/1/edit
  def edit
    @persona = Persona.find(params[:id])
     @cliente = @persona
    respond_to do |format|
      format.html { render :layout => 'special_form'}# new.html.erb
      #format.json { render json: @empresa }
    end
  end

  # POST /personas
  # POST /personas.json
  def create
    @persona = Persona.new(params[:persona])

    respond_to do |format|
      if @persona.save
        format.html { redirect_to @persona, :notice => 'Persona was successfully created.' }
        format.json { render json: @persona, status: :created, location: @persona }
      else
        format.html { render :action => "new" }
        format.json { render json: @persona.errors }
      end
    end
  end

  # PUT /personas/1
  # PUT /personas/1.json
  def update
    @persona = Persona.find(params[:id])

    respond_to do |format|
      if @persona.update_attributes(params[:persona])
        format.html { redirect_to @persona, :notice => 'Persona was successfully updated.' }
        format.json { render json: @persona }
      else
        format.html { render :action => "edit" }
        format.json { render json: @persona.errors }
      end
    end
  end

  # DELETE /personas/1
  # DELETE /personas/1.json
  def destroy
    @persona = Persona.find(params[:id])
    @persona.destroy

    respond_to do |format|
      format.html { redirect_to personas_url }
      #format.json { head :ok }
    end
  end
end

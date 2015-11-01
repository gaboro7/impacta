class DomiciliosController < ApplicationController

  before_filter :authenticate

  # GET /domicilios
  # GET /domicilios.json
  def index
    @persona = Persona.find(params[:persona_id])
    @domicilios = @persona.domicilioents.all

    respond_to do |format|
      format.html # index.html.erb
      #format.json { render json: @domicilios }
    end
  end

  # GET /domicilios/1
  # GET /domicilios/1.json
  def show
    @persona = Persona.find(params[:persona_id])
    @domicilio = @persona.domicilioents.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      #format.json { render json: @domicilio }
    end
  end

  # GET /domicilios/new
  # GET /domicilios/new.json
  def new
    @domicilio = Domicilio.new

    respond_to do |format|
      format.html # new.html.erb
      #format.json { render json: @domicilio }
    end
  end

  # GET /domicilios/1/edit
  def edit
    @persona = Persona.find(params[:persona_id])
    @domicilio = @persona.domicilioents.find(params[:id])
  end

  # POST /domicilios
  # POST /domicilios.json
  def create
    @persona = Persona.find(params[:persona_id])
    @domicilio = Domicilio.new(params[:domicilio])
    @persona.domicilioents << @domicilio

    respond_to do |format|
      if @domicilio.save
        format.html { redirect_to @persona, :notice => 'Domicilio was successfully created.' }
        #format.json { render json: @domicilio, status: :created, location: @domicilio }
      else
        format.html { render :action => "new" }
        #format.json { render json: @domicilio.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /domicilios/1
  # PUT /domicilios/1.json
  def update
    @persona = Persona.find(params[:persona_id])

    respond_to do |format|
      if @persona.domicilioents.find(params[:id]).update_attributes(params[:domicilio])
        format.html { redirect_to @persona, :notice => 'Domicilio was successfully updated.' }
        #format.json { head :ok }
      else
        format.html { render :action => "edit" }
        #format.json { render json: @domicilio.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /domicilios/1
  # DELETE /domicilios/1.json
  def destroy
    @persona = Persona.find(params[:persona_id])
    @domicilio = @persona.domicilioents.find(params[:id]).destroy

    respond_to do |format|
      format.html { redirect_to @persona }
     #format.json { head :ok }
    end
  end
end

class RenglonNotacreditosController < ApplicationController

  before_filter :authenticate

  # GET /renglon_notacreditos
  # GET /renglon_notacreditos.json
  def index
    @notadecredito = Notadecredito.find(params[:notadecredito_id])
    @renglon_notacreditos = @notadecredito.renglon_notacreditos

    respond_to do |format|
      format.html # index.html.erb
      #format.json { render json: @renglon_notacreditos }
    end
  end

  # GET /renglon_notacreditos/1
  # GET /renglon_notacreditos/1.json
  def show
    @notadecredito = Notadecredito.find(params[:notadecredito_id])
    @renglon_notacredito = @notadecredito.renglon_notacreditos.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      #format.json { render json: @renglon_notacredito }
    end
  end

  # GET /renglon_notacreditos/new
  # GET /renglon_notacreditos/new.json
  def new
    @renglon_notacredito = RenglonNotacredito.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @renglon_notacredito }
    end
  end

  # GET /renglon_notacreditos/1/edit
  def edit
    @notadecredito = Notadecredito.find(params[:notadecredito_id])
    @renglon_notacredito = @notadecredito.renglon_notacreditos.find(params[:id])
    respond_to do |format|
      format.html { render :layout => 'special_form'}# new.html.erb
    end
  end

  # POST /renglon_notacreditos
  # POST /renglon_notacreditos.json
  def create
    @notadecredito = Notadecredito.find(params[:notadecredito_id])
    @renglon_notacredito = @notadecredito.renglon_notacreditos.build(params[:renglon_notacredito])

    respond_to do |format|
      if @renglon_notacredito.save
        format.html { redirect_to @notacredito, notice: 'Renglon notacredito was successfully created.' }
        format.json { render json: @renglon_notacredito}
      else
        format.html { render action: "new" }
        format.json { render json: @renglon_notacredito.errors}
      end
    end
  end

  # PUT /renglon_notacreditos/1
  # PUT /renglon_notacreditos/1.json
  def update
    @notadecredito = Notadecredito.find(params[:notadecredito_id])
    @renglon_notacredito = @notadecredito.renglon_notacreditos.find(params[:id])

    respond_to do |format|
      if @renglon_notacredito.update_attributes(params[:renglon_notacredito])
        format.html { redirect_to @notacredito, notice: 'Renglon notacredito was successfully updated.' }
        format.json { render json: @renglon_notacredito }
      else
        format.html { render action: "edit" }
        format.json { render json: @renglon_notacredito.errors}
      end
    end
  end

  # DELETE /renglon_notacreditos/1
  # DELETE /renglon_notacreditos/1.json
  def destroy
    @notadecredito = Notadecredito.find(params[:notadecredito_id])
    @renglon_notacredito = @notadecredito.renglon_notacreditos.find(params[:id]).destroy

    respond_to do |format|
      format.html { redirect_to notadecreditos_url }
      format.json { head :ok }
    end
  end
end

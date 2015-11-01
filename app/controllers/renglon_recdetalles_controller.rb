class RenglonRecdetallesController < ApplicationController

    before_filter :authenticate

  # GET /renglon_recdetalles
  # GET /renglon_recdetalles.json
  def index
    @recibo = Recibo.find(params[:recibo_id])
    @renglon_recdetalles = @recibo.renglon_recdetalles.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @renglon_recdetalles }
    end
  end

  # GET /renglon_recdetalles/1
  # GET /renglon_recdetalles/1.json
  def show

    @recibo = Recibo.find(params[:recibo_id])
    @renglon_recdetalle = @recibo.renglon_recdetalles.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @renglon_recdetalle }
    end
  end

  # GET /renglon_recdetalles/new
  # GET /renglon_recdetalles/new.json
  def new
    @renglon_recdetalle = RenglonRecdetalle.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @renglon_recdetalle }
    end
  end

  # GET /renglon_recdetalles/1/edit
  def edit
    @recibo = Recibo.find(params[:recibo_id])
    @renglon_recdetalle = @recibo.renglon_recdetalles.find(params[:id])
    respond_to do |format|
       format.html { render :layout => 'special_form'}# new.html.erb
      format.json { render json: @renglon_recdetalle }
    end
  end

  # POST /renglon_recdetalles
  # POST /renglon_recdetalles.json
  def create
    @recibo = Recibo.find(params[:recibo_id])
    @renglon_recdetalle = @recibo.renglon_recdetalles.create(params[:renglon_recdetalle])

    respond_to do |format|
      if @renglon_recdetalle.save
        format.html { redirect_to @recibo, notice: 'Renglon recdetalle was successfully created.' }
        format.json { render json: @renglon_recdetalle }
      else
        format.html { render action: "new" }
        format.json { render json: @renglon_recdetalle.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /renglon_recdetalles/1
  # PUT /renglon_recdetalles/1.json
  def update
    @recibo = Recibo.find(params[:recibo_id])
    @renglon_recdetalle = @recibo.renglon_recdetalles.find(params[:id])

    respond_to do |format|
      if @renglon_recdetalle.update_attributes(params[:renglon_recdetalle])
        format.html { redirect_to @recibo, notice: 'Renglon recdetalle was successfully updated.' }
        format.json { render json: @renglon_recdetalle }
      else
        format.html { render action: "edit" }
        format.json { render json: @renglon_recdetalle.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /renglon_recdetalles/1
  # DELETE /renglon_recdetalles/1.json
  def destroy
    @recibo = Recibo.find(params[:recibo_id])
    @renglon_recdetalle = @recibo.renglon_recdetalles.find(params[:id]).destroy

    respond_to do |format|
      format.html { head :ok }
      format.json { head :ok }
    end
  end
end

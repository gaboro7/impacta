class RenglonRecibosController < ApplicationController

  before_filter :authenticate

  # GET /renglon_recibos
  # GET /renglon_recibos.json
  def index
    @recibo = Recibo.find(params[:recibo_id])
    @renglon_recibos = @recibo.renglon_recibos.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @renglon_recibos }
    end
  end

  # GET /renglon_recibos/1
  # GET /renglon_recibos/1.json
  def show

    @recibo = Recibo.find(params[:recibo_id])
    @renglon_recibo = @recibo.renglon_recibos.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @renglon_recibo }
    end
  end

  # GET /renglon_recibos/new
  # GET /renglon_recibos/new.json
  def new
    @renglon_recibo = RenglonRecibo.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @renglon_recibo }
    end
  end

  # GET /renglon_recibos/1/edit
  def edit
    @recibo = Recibo.find(params[:recibo_id])
    @renglon_recibo = @recibo.renglon_recibos.find(params[:id])
    respond_to do |format|
      format.html { render :layout => 'special_form'}# new.html.erb
      format.json { render json: @renglon_recibo }
    end
  end

  # POST /renglon_recibos
  # POST /renglon_recibos.json
  def create
    @recibo = Recibo.find(params[:recibo_id])
    @renglon_recibo = @recibo.renglon_recibos.build(params[:renglon_recibo])

    respond_to do |format|
      if @renglon_recibo.save
        #format.html { redirect_to @recibo, notice: 'Renglon recibo was successfully created.' }
        format.json { render json: @renglon_recibo }
      else
        #format.html { render action: "new" }
        format.json { render json: @renglon_recibo.errors }
      end
    end
  end

  # PUT /renglon_recibos/1
  # PUT /renglon_recibos/1.json
  def update
    @recibo = Recibo.find(params[:recibo_id])
    @renglon_recibo = @recibo.renglon_recibos.find(params[:id])

    respond_to do |format|
      if @renglon_recibo.update_attributes(params[:renglon_recibo])
        #format.html { redirect_to @recibo, notice: 'Renglon recibo was successfully updated.' }
        format.json { render json: @renglon_recibo }
      else
        #format.html { render action: "edit" }
        format.json { render json: @renglon_recibo.errors }
      end
    end
  end

  # DELETE /renglon_recibos/1
  # DELETE /renglon_recibos/1.json
  def destroy
    @recibo = Recibo.find(params[:recibo_id])
    respond_to do |format|
      if @renglon_recibo = @recibo.renglon_recibos.find(params[:id]).destroy
        format.html { head :ok }
        format.json { head :ok }
      else
        format.html { head :ok }
        format.json { head :ok }
      end
    end
  end
end

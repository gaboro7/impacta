class RenglonNdcnddsController < ApplicationController

  before_filter :authenticate

  # GET /renglon_ndcndds
  # GET /renglon_ndcndds.json
  def index
    @notadecredito = Notadecredito.find(params[:notadecredito_id])
    @renglon_ndcndds = @notadecredito.renglon_ndcndds

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @renglon_ndcndds }
    end
  end

  # GET /renglon_ndcndds/1
  # GET /renglon_ndcndds/1.json
  def show
    @notadecredito = Notadecredito.find(params[:notadecredito_id])
    @renglon_ndcndd = @notadecredito.renglon_ndcndds.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @renglon_ndcndd }
    end
  end

  # GET /renglon_ndcndds/new
  # GET /renglon_ndcndds/new.json
  def new
    @renglon_ndcndd = RenglonNdcndd.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @renglon_ndcndd }
    end
  end

  # GET /renglon_ndcndds/1/edit
  def edit
    @notadecredito = Notadecredito.find(params[:notadecredito_id])
    @renglon_ndcndd = @notadecredito.renglon_ndcndds.find(params[:id])
    respond_to do |format|
      format.html { render :layout => 'special_form'}# new.html.erb
    end


  end

  # POST /renglon_ndcndds
  # POST /renglon_ndcndds.json
  def create

    @notadecredito = Notadecredito.find(params[:notadecredito_id])
    @renglon_ndcndd = @notadecredito.renglon_ndcndds.build(params[:renglon_ndcndd])

    respond_to do |format|
      if @renglon_ndcndd.save
        format.html { redirect_to @notadecredito, notice: 'Renglon ndcdetalle was successfully created.' }
        format.json { render json: @renglon_ndcndd}
      else
        format.html { render action: "new" }
        format.json { render json: @renglon_ndcndd.errors}
      end
    end
  end

  # PUT /renglon_ndcndds/1
  # PUT /renglon_ndcndds/1.json
  def update
    @notadecredito = Notadecredito.find(params[:notadecredito_id])
    @renglon_ndcndd = @notadecredito.renglon_ndcndds.find(params[:id])

    respond_to do |format|
      if @renglon_ndcndd.update_attributes(params[:renglon_ndcndd])
        format.html { redirect_to @renglon_ndcndd, notice: 'Renglon ndcdetalle was successfully updated.' }
        format.json { render json: @renglon_ndcndd }
      else
        format.html { render action: "edit" }
        format.json { render json: @renglon_ndcndd.errors}
      end
    end
  end

  # DELETE /renglon_ndcndds/1
  # DELETE /renglon_ndcndds/1.json
  def destroy

    @notadecredito = Notadecredito.find(params[:notadecredito_id])
    @renglon_ndcndd = @notadecredito.renglon_ndcndds.find(params[:id]).destroy

    respond_to do |format|
      format.html { head :ok }
      format.json { head :ok }
    end
  end
end

class ArticulocompsController < ApplicationController

  before_filter :authenticate

  # GET /articulocomps
  # GET /articulocomps.json
  def index
    @articulocomps = Articulocomp.all

    respond_to do |format|
      format.html # index.html.erb
      #format.json { render json: @articulocomps }
    end
  end

  # GET /articulocomps/1
  # GET /articulocomps/1.json
  def show
    @articulocomp = Articulocomp.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      #format.json { render json: @articulocomp }
    end
  end

  # GET /articulocomps/new
  # GET /articulocomps/new.json
  def new
    @articulocomp = Articulocomp.new

    respond_to do |format|
      format.html # new.html.erb
      #format.json { render json: @articulocomp }
    end
  end

  # GET /articulocomps/1/edit
  def edit
    @articulocomp = Articulocomp.find(params[:id])
  end

  # POST /articulocomps
  # POST /articulocomps.json
  def create
    @articulocomp = Articulocomp.new(params[:articulocomp])

    respond_to do |format|
      if @articulocomp.save
        format.html { redirect_to @articulocomp, :notice => 'Articulocomp was successfully created.' }
        #format.json { render json: @articulocomp, status: :created, location: @articulocomp }
      else
        format.html { render :action => "new" }
        #format.json { render json: @articulocomp.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /articulocomps/1
  # PUT /articulocomps/1.json
  def update
    @articulocomp = Articulocomp.find(params[:id])

    respond_to do |format|
      if @articulocomp.update_attributes(params[:articulocomp])
        format.html { redirect_to @articulocomp, :notice => 'Articulocomp was successfully updated.' }
        #format.json { head :ok }
      else
        format.html { render :action => "edit" }
        #format.json { render json: @articulocomp.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /articulocomps/1
  # DELETE /articulocomps/1.json
  def destroy
    @articulocomp = Articulocomp.find(params[:id])
    @articulocomp.destroy

    respond_to do |format|
      format.html { redirect_to articulocomps_url }
      #format.json { head :ok }
    end
  end
end

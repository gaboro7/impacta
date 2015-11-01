class RolarticulosController < ApplicationController

  before_filter :authenticate

  # GET /rolarticulos
  # GET /rolarticulos.json
  def index
    @rola = find_rola
    @rolarticulos = @rola.rolarticulos

    respond_to do |format|
      format.html # index.html.erb
      #format.json { render json: @rolarticulos }
    end
  end

  # GET /rolarticulos/1
  # GET /rolarticulos/1.json
  def show
    @rola = find_rola
    @rolarticulos = @rola.rolarticulo.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      #format.json { render json: @rolarticulo }
    end
  end

  # GET /rolarticulos/new
  # GET /rolarticulos/new.json
  def new
    @rolarticulo = Rolarticulo.new

    respond_to do |format|
      format.html # new.html.erb
      #format.json { render json: @rolarticulo }
    end
  end

  # GET /rolarticulos/1/edit
  def edit
    @rola = find_rola
    @rolarticulos = @rola.rolarticulo.find(params[:id])
  end

  # POST /rolarticulos
  # POST /rolarticulos.json
  def create
    @rola = find_rola
    @rolarticulos = @rola.rolarticulos.create(params[:rolarticulo])
    

    respond_to do |format|
      if @rolarticulos.save
        format.html { redirect_to @rola, :notice => 'Rolarticulo was successfully created.' }
        #format.json { render json: @articulo, status: :created, location: @articulo }
      else
        format.html { render :action => "new" }
        #format.json { render json: @articulo.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /rolarticulos/1
  # PUT /rolarticulos/1.json
  def update
    @rola = find_rola
    @rolarticulos = @rola.rolarticulo.find(params[:id])

    respond_to do |format|
      if @rolarticulos.update_attributes(params[:rolarticulo])
        format.html { redirect_to :id => nil, :notice => 'Rolarticulo was successfully updated.' }
        #format.json { head :ok }
      else
        format.html { render :action => "edit" }
        #format.json { render json: @articulo.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /rolarticulos/1
  # DELETE /rolarticulos/1.json
  def destroy
    @rola = find_rola
    @rolarticulos = @rola.rolarticulos.find(params[:id])
    @rolarticulos.destroy

    respond_to do |format|
      format.html { redirect_to articulos_url }
      #format.json { head :ok }
    end
  end
  
  private
  
  def find_rola
    params.each do |name, value|
      if name =~ /(.+)_id$/
        return $1.classify.constantize.find(value)
      end
    end
    nil
  end
  
end


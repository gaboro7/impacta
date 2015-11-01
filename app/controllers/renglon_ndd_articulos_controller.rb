class RenglonNddArticulosController < ApplicationController
  before_filter :authenticate

  # GET /renglon_ndd_articulos
  # GET /renglon_ndd_articulos.json
  def index

    @notadedebito = Notadedebito.find(params[:notadedebito_id])
    @renglon_ndd_articulos = @notadedebito.renglon_ndd_articulos

    respond_to do |format|
      format.html # index.html.erb
    end
  end

  # GET /renglon_ndd_articulos/1
  # GET /renglon_ndd_articulos/1.json
  def show

    @notadedebito = Notadedebito.find(params[:notadedebito_id])
    @renglon_ndd_articulo = @notadedebito.renglon_ndd_articulos.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
    end
  end

  # GET /renglon_ndd_articulos/new
  # GET /renglon_ndd_articulos/new.json
  def new
    @renglon_ndd_articulo = RenglonnddArticulo.new

    respond_to do |format|
      format.html # new.html.erb
      #format.json { render json: @renglon_ndd_articulo }
    end
  end

  # GET /renglon_ndd_articulos/1/edit
  def edit

    @notadedebito = Notadedebito.find(params[:notadedebito_id])
    @renglon_ndd_articulo = @notadedebito.renglon_ndd_articulos.find(params[:id])

    respond_to do |format|
      format.html { render :layout => 'special_form'}# new.html.erb
    end
  end

  # POST /renglon_ndd_articulos
  # POST /renglon_ndd_articulos.json
  def create


    @notadedebito = Notadedebito.find(params[:notadedebito_id])
    @renglon_ndd_articulo = @notadedebito.renglon_ndd_articulos.build(params[:renglon_ndd_articulo])

    respond_to do |format|
      if @renglon_ndd_articulo.save
        format.html { redirect_to @notadedebito, :notice => 'Renglon ndd Articulo was successfully created.' }
        format.json { render json: @renglon_ndd_articulo }
      else
        format.html { render :action => "new" }
        format.json { render json: @renglon_ndd_articulo.errors }

      end
    end

  end

  # PUT /renglon_ndd_articulos/1
  # PUT /renglon_ndd_articulos/1.json
  def update
    @notadedebito = Notadedebito.find(params[:notadedebito_id])
    @renglon_ndd_articulo = @notadedebito.renglon_ndd_articulos.find(params[:id])

    respond_to do |format|
      if @renglon_ndd_articulo.update_attributes(params[:renglon_ndd_articulo])
        format.html { redirect_to @notadedebito, :notice => 'Renglon ndd Articulo was successfully updated.' }
        format.json { render json: @renglon_ndd_articulo }
      else
        format.html { render :action => "edit" }
        format.json { render json: @renglon_ndd_articulo.errors }
      end
    end

  end

  # DELETE /renglon_ndd_articulos/1
  # DELETE /renglon_ndd_articulos/1.json
  def destroy
    @notadedebito = Notadedebito.find(params[:notadedebito_id])
    @renglon_ndd_articulo = @notadedebito.renglon_ndd_articulos.find(params[:id]).destroy

    respond_to do |format|
      format.html { head :ok }
      #format.json { head :ok }
    end
  end
end

class ArticuloindsController < ApplicationController

  before_filter :authenticate

  # GET /articuloinds
  # GET /articuloinds.json
  def index
    #@conf_busqueda_articulos configuracion de la busqueda
    # 1: busqueda por coincidencia exacta primero despues por empieza luego por contiene (en los parametros id y nombre) y las concatena
    # 0: busca por contiene (en los parametros id y nombre)
    @conf_busqueda_articulos = 1

    if !params[:comercializable].nil?
      if !params[:lista_precio_id].nil?
        @articuloinds = Comercializable.get_comercializable_cliente_filter(params[:lista_precio_id],params[:comercializable])
      else
        @articuloinds = Articuloind.where("nombre like '%"+params[:comercializable].to_s+"%' or id like '%"+params[:comercializable].to_s+"%'")
      end
      respond_to do |format|
         format.json { render json: @articuloinds }
      end
    else 
      if !params[:filtro].nil?
        if (@conf_busqueda_articulos == 1)
          @articuloinds1 = Articuloind.where("id like '"+params[:filtro].to_s+"'")
          @articuloinds2 = Articuloind.where("nombre like '"+params[:filtro].to_s+"' and id not like '"+params[:filtro].to_s+"'")
          @articuloinds3 = Articuloind.where("nombre like '"+params[:filtro].to_s+"%' and not (nombre like '"+params[:filtro].to_s+"' or id like '"+params[:filtro].to_s+"')")
          @articuloinds4 = Articuloind.where("(nombre like '%"+params[:filtro].to_s+"%' or id like '%"+params[:filtro].to_s+"%') and not (nombre like '"+params[:filtro].to_s+"%' or id like '"+params[:filtro].to_s+"')")
          @articuloinds = @articuloinds1 + @articuloinds2 + @articuloinds3 + @articuloinds4
        else
          @articuloinds =  Articuloind.where("nombre like '%"+params[:filtro].to_s+"%' or id like '%"+params[:filtro].to_s+"%')")
        end
      else
        @articuloinds = Articuloind.paginate(:page => params[:numero_hoja], :per_page => 18)
      end
      if params[:numero_hoja].nil?
        respond_to do |format|
          format.html # index.html.erb
          format.json { render json: @articuloinds }
        end
      else
        respond_to do |format|
          format.html  { render :layout => "application_paginate"}# index.html.erb
          #format.json { render json: @impuestos }
        end
      end
    end
  end



  # GET /articuloinds/1
  # GET /articuloinds/1.json
  def show
    @articuloind = Articuloind.find(params[:id])

    
    respond_to do |format|
      format.html # show.html.erb
      #format.json { render json: @articuloind }
    end
  end

  # GET /articuloinds/new
  # GET /articuloinds/new.json
  def new
    @articuloind = Articuloind.new

    respond_to do |format|
      format.html { render :layout => 'special_form'}# new.html.erb
      #format.json { render json: @articuloind }
    end
  end

  # GET /articuloinds/1/edit
  def edit
    @articuloind = Articuloind.find(params[:id])
    respond_to do |format|
      format.html { render :layout => 'special_form'}# new.html.erb
      #format.json { render json: @articuloind }
    end
  end

  # POST /articuloinds
  # POST /articuloinds.json
  def create
    @articuloind = Articuloind.new(params[:articuloind])

    respond_to do |format|
      if @articuloind.save
        format.html { redirect_to @articuloind, :notice => 'Articuloind was successfully created.' }
        format.json { render json: @articuloind, status: :created, location: @articuloind }
      else
        format.html { render :action => "new" }
        format.json { render json: @articuloind.errors}
      end
    end
  end

  # PUT /articuloinds/1
  # PUT /articuloinds/1.json
  def update
    @articuloind = Articuloind.find(params[:id])

    respond_to do |format|
      if @articuloind.update_attributes(params[:articuloind])
        format.html { redirect_to @articuloind, :notice => 'Articuloind was successfully updated.' }
        format.json { render json: @articuloind }
      else
        format.html { render :action => "edit" }
        format.json { render json: @articuloind.errors }
      end
    end
  end

  # DELETE /articuloinds/1
  # DELETE /articuloinds/1.json
  def destroy
    @articuloind = Articuloind.find(params[:id])
    @articuloind.destroy

    respond_to do |format|
      format.html { redirect_to articuloinds_url }
      #format.json { head :ok }
    end
  end
end

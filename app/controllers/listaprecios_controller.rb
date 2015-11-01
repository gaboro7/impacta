class ListapreciosController < ApplicationController

  before_filter :authenticate

  # GET /listaprecios
  # GET /listaprecios.json
  def index
    @listaprecios = Listaprecio.paginate(:page => params[:numero_hoja], :per_page => 18)
    if params[:numero_hoja].nil?
      respond_to do |format|
        format.html # index.html.erb
        #format.json { render json: @listaprecios }
      end
    else
      respond_to do |format|
        format.html  { render :layout => "application_paginate"}# index.html.erb
        #format.json { render json: @impuestos }
      end
    end
  end

  def getPrecioArticuloCliente
    if params[:comercializable_id] != ''
      @cliente  = Cliente.find(params[:cliente_id])
      @articulo = Comercializable.find(params[:comercializable_id]);

      @lista_precio_id = -1
      if (@cliente.listaprecio != nil)
        @lista_precio_id =@cliente.listaprecio.id.to_s
      end
  

      @precio_articulo = Precioart.where("listaprecio_id  = ? and comercializable_id = ?",@lista_precio_id,params[:comercializable_id] )
      @desc_cli_articulo = DescuentoCliente.where("cliente_id  = ? and comercializable_id = ?", params[:cliente_id], params[:comercializable_id] )
    else
      @articulo= nil
    end
    @promocion = nil
    if params[:factura_id] != nil
      @factura = Factura.find(params[:factura_id])
      @promocion = @articulo.get_promocion_actual(params[:cliente_id],@factura.formadepago.id)
    end


    respond_to do |format|
      format.html  { render json: @precio_articulo }
      if (@articulo != nil)
        format.json { render json:{ :precio => @precio_articulo, :articulo => @articulo.as_json(:include => [:impuestos]), :promociones => @promocion, :cliente => @cliente, :desc_cli_articulo => @desc_cli_articulo}}
      else
        format.json { render json:{}}
      end
    end
  end

  def importarcliente
    @listaprecio = Listaprecio.find(params[:id])
    @cliente = Cliente.find(params[:cliente_id])
    @listaprecio.clientes << @cliente;
    @listaprecio.save
    respond_to do |format|
      format.html  { render json: :ok }
      format.json { render json:{ }}
      end
   end
  


  # GET /listaprecios/1
  # GET /listaprecios/1.json
  def show
    @listaprecio = Listaprecio.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      #format.json { render json: @listaprecio }
    end
  end

  # GET /listaprecios/new
  # GET /listaprecios/new.json
  def new
    @listaprecio = Listaprecio.new

    respond_to do |format|
      format.html { render :layout => 'special_form'}# new.html.erb
      #format.json { render json: @listaprecio }
    end
  end

  # GET /listaprecios/1/edit
  def edit
    @listaprecio = Listaprecio.find(params[:id],:include => :precioarts)
    respond_to do |format|
      format.html { render :layout => 'special_form'}# new.html.erb
      #format.json { render json: @listaprecio }
    end
  end

  # POST /listaprecios
  # POST /listaprecios.json
  def create
    @listaprecio = Listaprecio.new(params[:listaprecio])

    respond_to do |format|
      if @listaprecio.save
        format.html { redirect_to @listaprecio, :notice => 'Listaprecio was successfully created.' }
        format.json { render json: @listaprecio, status: :created, location: @listaprecio }
      else
        format.html { render :action => "new" }
        format.json { render json: @listaprecio.errors }
      end
    end
  end

  # PUT /listaprecios/1
  # PUT /listaprecios/1.json
  def update
    @listaprecio = Listaprecio.find(params[:id])

    if (params[:listaprecio][:cliente_ids] == nil)
      params[:listaprecio][:cliente_ids] = []
    end

    respond_to do |format|
      if @listaprecio.update_attributes(params[:listaprecio])
        format.html { redirect_to @listaprecio, :notice => 'Listaprecio was successfully updated.' }
        format.json { render json: @listaprecio }
      else
        format.html { render :action => "edit" }
        format.json { render json: @listaprecio.errors }
      end
    end
  end

  # DELETE /listaprecios/1
  # DELETE /listaprecios/1.json
  def destroy
    @listaprecio = Listaprecio.find(params[:id])
    @listaprecio.destroy

    respond_to do |format|
      format.html { redirect_to listaprecios_url }
      #format.json { head :ok }
    end
  end

  def copiarlista
    @listacopiada = Listaprecio.find(params[:id])
    @listaprecio = Listaprecio.new(:nombre => params[:nombre])
    respond_to do |format|
      if @listaprecio.save

        for pa in @listacopiada.precioarts
          @precioarts = @listaprecio.precioarts.create(:comercializable_id => pa.comercializable.id, :precio => pa.precio, :descuento => pa.descuento)
          @precioarts.save
        end

        format.html { redirect_to @listaprecio, :notice => 'Listaprecio was successfully created.' }
        format.json { render json: @listaprecio, status: :created, location: @listaprecio }
      else
        format.html { render :action => "new" }
        format.json { render json: @listaprecio.errors }
      end
    end
  end


end

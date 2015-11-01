class DescuentoClientesController < ApplicationController

  before_filter :authenticate

  # GET /descuento_clientes
  # GET /descuento_clientes.json
  def index
    @descuento_clientes = DescuentoCliente.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @descuento_clientes }
    end
  end

  # GET /descuento_clientes/1
  # GET /descuento_clientes/1.json
  def show
    @descuento_cliente = DescuentoCliente.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @descuento_cliente }
    end
  end

  # GET /descuento_clientes/new
  # GET /descuento_clientes/new.json
  def new
    @descuento_cliente = DescuentoCliente.new

    respond_to do |format|
      format.html { render :layout => 'special_form'}
    end
  end

  # GET /descuento_clientes/1/edit
  def edit

    @cliente = find_cliente
    @descuento_cliente = @cliente.descuento_clientes.find(params[:id])

    respond_to do |format|
      format.html { render :layout => 'special_form'}

    end


  end

  # POST /descuento_clientes
  # POST /descuento_clientes.json
  def create

    @cliente = Cliente.find(params[:cliente_id])
    @descuento_cliente = @cliente.descuento_clientes.build(params[:descuento_cliente])

    respond_to do |format|
      if @descuento_cliente.save
        #format.html { redirect_to redirigir(@contelefono), :notice => 'El telefono fue ingresado correctamente.' }
        format.json { render json: @descuento_cliente}
      else
        #format.html { render :action => "new" }
        format.json { render json: @descuento_cliente.errors }
      end
    end
  end

  # PUT /descuento_clientes/1
  # PUT /descuento_clientes/1.json
  def update

    @cliente = find_cliente
    @descuento_cliente = @cliente.descuento_clientes.find(params[:id])

    respond_to do |format|

      if @descuento_cliente.update_attributes(params[:descuento_cliente])
        #format.html { redirect_to redirigir(@contelefono), :notice => 'El telefono fue actualizado correctamente.' }
        format.json {  render json: @descuento_cliente }
      else
        #format.html { render :action => "edit" }
        format.json { render json: @descuento_cliente.errors }
      end

    end

  end

  # DELETE /descuento_clientes/1
  # DELETE /descuento_clientes/1.json
  def destroy
    @cliente = find_cliente
    @descuento_cliente = @cliente.descuento_clientes.find(params[:id]).destroy

    respond_to do |format|
       format.html { head :ok}

    end
  end

  def find_cliente
    @values=[]
    @names=[]
    @i=0
    params.each do |name, value|
      if name =~ /(.+)_id$/
        @names[@i]=$1
        @values[@i]=value
        @i+=1
      end
    end
    return @names[@i-1].classify.constantize.find(@values[@i-1])
    nil
  end


end

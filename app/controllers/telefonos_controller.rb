class TelefonosController < ApplicationController

  before_filter :authenticate

  # GET /telefonos
  # GET /telefonos.json
  def index
    @contelefono = find_contelefono
    @telefonos = @contelefono.telefonos

    respond_to do |format|
      format.html # index.html.erb
                  #format.json { render json: @telefonos }
    end

  end

  # GET /telefonos/1
  # GET /telefonos/1.json
  def show
    @contelefono = find_contelefono
    @telefono = @contelefono.telefonos.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
                  #format.json { render json: @telefono }
    end
  end

  # GET /telefonos/new
  # GET /telefonos/new.json
  def new
    @telefono = Telefono.new

    respond_to do |format|
      format.html { render :layout => 'special_form'}# new.html.erb
                  #format.json { render json: @telefono }
    end
  end

  # GET /telefonos/1/edit
  def edit
    @contelefono = find_contelefono
    @telefono = @contelefono.telefonos.find(params[:id])

    @redirigir = redirigir(@contelefono)

    respond_to do |format|
      format.html { render :layout => 'special_form'}

    end
  end

  # POST /telefonos
  # POST /telefonos.json
  def create
    @contelefono = find_contelefono
    @telefono = Telefono.new(params[:telefono])
    @contelefono.telefonos << @telefono

    respond_to do |format|
      if @contelefono.save
        #format.html { redirect_to redirigir(@contelefono), :notice => 'El telefono fue ingresado correctamente.' }
        format.json { render json: @contelefono}
      else
        #format.html { render :action => "new" }
        format.json { render json: @telefono.errors }
      end
    end
  end

  # PUT /telefonos/1
  # PUT /telefonos/1.json
  def update
    @contelefono = find_contelefono

    @redirigir = redirigir(@contelefono)
    @telefono = @contelefono.telefonos.find(params[:id])

    respond_to do |format|

      if @telefono.update_attributes(params[:telefono])
#        format.html { redirect_to redirigir(@contelefono), :notice => 'El telefono fue actualizado correctamente.' }
        format.json { render json: @contelefono, :notice => 'El telefono fue actualizado correctamente.' }
      else
#        format.html { render :action => "edit" }
        format.json { render json: @telefono.errors }
      end

    end
  end

  # DELETE /telefonos/1
  # DELETE /telefonos/1.json
  def destroy
    @contelefono = find_contelefono
    @contelefono.telefonos.find(params[:id]).destroy

    respond_to do |format|
      format.html { head :ok}
      #format.json { head :ok }
    end
  end

  def redirigir contelefono
    if @contelefono.class.name == "Empresa"
      @idemp = @contelefono.id.to_s
      @goto = "/empresas/"+@idemp

    elsif @contelefono.class.name == "Persona"
      @idper = @contelefono.id.to_s
      @goto = "/personas/"+@idper

    elsif @contelefono.class.name == "Sucursal"
      @idemp = @contelefono.empresa.id.to_s
      @idenc = @contelefono.id.to_s
      @goto = "/empresas/"+@idemp+"/sucursals/"+@idenc

    elsif @contelefono.class.name == "Contacto"
      if  @contelefono.contactable.class.name == "Empresa"
        @idemp = @contelefono.contactable.id.to_s
        @idcon = @contelefono.id.to_s
        @goto = "/empresas/"+@idemp+"/contactos/"+@idcon
      elsif @contelefono.contactable.class.name == "Sucursal"
        @idemp = @contelefono.contactable.empresa.id.to_s
        @idsuc = @contelefono.contactable.id.to_s
        @idcon = @contelefono.id.to_s
        @goto = "/empresas/"+@idemp+"/sucursals/"+@idsuc+"/contactos/"+@idcon

      end

    end

    return @goto

  end


  def find_contelefono
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

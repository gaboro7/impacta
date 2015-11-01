class ContactosController < ApplicationController

  before_filter :authenticate

  # GET /contactos
  # GET /contactos.json
  def index
    @contactable = find_contactable
    @contactos = @contactable.contactos

    respond_to do |format|
      format.html # index.html.erb
      #format.json { render json: @contactos }
    end
  end

  # GET /contactos/1
  # GET /contactos/1.json
  def show
    @contactable = find_contactable
    @contacto = @contactable.contactos.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      #format.json { render json: @contacto }
    end
  end

  # GET /contactos/new
  # GET /contactos/new.json
  def new
    @contacto = Contacto.new
  
    respond_to do |format|
      format.html { render :layout => 'special_form'}# new.html.erb
      #format.json { render json: @contacto }
    end
  end

  # GET /contactos/1/edit
  def edit
    @contactable = find_contactable
   
    @contacto = @contactable.contactos.find(params[:id])
   print @contacto.id.to_s + " asdfsadfasdfasdfddsaf"
    respond_to do |format|
      format.html { render :layout => 'special_form'}# new.html.erb
      #format.json { render json: @empresa }
    end
  end

  # POST /contactos
  # POST /contactos.json
  def create
    @contactable = find_contactable
    @contacto = Contacto.new(params[:contacto])
    @contactable.contactos << @contacto

    respond_to do |format|
      if @contacto.save
        if @contactable.class.name == "Empresa"
          format.html { redirect_to @contactable, :notice => 'El Contacto se creo satisfactoriamente' }
        elsif @contactable.class.name == "Sucursal"
          @empresa = @contactable.empresa
          @idene = @empresa.id.to_s
          @idenc = @contactable.id.to_s
        #  format.html { redirect_to "/empresas/"+@idene+"/sucursals/"+@idenc, :notice => 'El Contacto se creo satisfactoriamente' }
          format.html { head :ok}
          format.json { render json: @contactable }
          #format.html { redirect_to empresa_sucursal_path(@empresa, @contactable), notice: 'El Contacto se creo satisfactoriamente' }
        end
      else
        format.html { head :ok}
       # format.html { render :action => "new" }
        format.json { render json: @contactable.errors }
      end
    end
  end

  # PUT /contactos/1
  # PUT /contactos/1.json
  def update
    @contactable = find_contactable
    respond_to do |format|
      if @contactable.contactos.find(params[:id]).update_attributes(params[:contacto])
        if@contactable.class.name == "Empresa"
          format.html { redirect_to @contactable, :notice => 'El Contacto se creo satisfactoriamente' }
        elsif @contactable.class.name == "Sucursal"
          @empresa = @contactable.empresa
          @idene = @empresa.id.to_s
          @idenc = @contactable.id.to_s
           format.html { head :ok}
          #format.html { redirect_to "/empresas/"+@idene+"/sucursals/"+@idenc, notice: 'El Contacto se creo satisfactoriamente' }
         # format.html { redirect_to empresa_sucursal_path(@empresa, @contactable), :notice => 'El Contacto se creo satisfactoriamente' }
          format.json { render json: @contactable }
        end
        #format.json { head :ok }
      else
         format.html { head :ok}
        #format.html { render :action => "edit" }
        format.json { render json: @contactable.errors }
        #format.json { render json: @contacto.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /contactos/1
  # DELETE /contactos/1.json
  def destroy
    @contactable = find_contactable
    @contactable.contactos.find(params[:id]).destroy
    respond_to do |format|
      format.html { head :ok}
    #  format.html { redirect_to @contactable }
      #format.json { head :ok }
    end
  end

  private

  def find_contactable
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

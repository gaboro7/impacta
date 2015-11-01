class MailInternosController < ApplicationController

  before_filter :authenticate

  # GET /mails
  # GET /mails.json
  def index
    @conmail = find_conmail
    @mails = @conmail.mail_internos

    respond_to do |format|
      format.html # index.html.erb
                  #format.json { render json: @mails }
    end

  end

  # GET /mails/1
  # GET /mails/1.json
  def show
    @conmail = find_conmail
    @mail = @conmail.mail_internos.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
                  #format.json { render json: @mail }
    end
  end

  # GET /mails/new
  # GET /mails/new.json
  def new
    @mail = MailInterno.new

    respond_to do |format|
      format.html { render :layout => 'special_form'}# new.html.erb
                  #format.json { render json: @mail }
    end
  end

  # GET /mails/1/edit
  def edit
    @conmail = find_conmail
    @mail = @conmail.mail_internos.find(params[:id])

    @redirigir = redirigir(@conmail)

    respond_to do |format|
      format.html { render :layout => 'special_form'}

    end
  end

  # POST /mails
  # POST /mails.json
  def create
    @conmail = find_conmail
    @mail = MailInterno.new(params[:mail])
    #return render :text => "The object is #{@conmail.nombre}"
    @conmail.mail_internos << @mail

    #@redirigir = redirigir(@conmail)

    respond_to do |format|
      if @conmail.save
        #format.html { redirect_to redirigir(@conmail), :notice => 'El mail fue ingresado correctamente.' }
        format.json { render json: @conmail}
      else
        #format.html { render :action => "new" }
        format.json { render json: @mail.errors , :notice => 'error'}
      end
    end
  end

  # PUT /mails/1
  # PUT /mails/1.json
  def update
    @conmail = find_conmail

    #@redirigir = redirigir(@conmail)
    @mail = @conmail.mail_internos.find(params[:id])

    respond_to do |format|

      if @mail.update_attributes(params[:mail])
        #format.html { redirect_to redirigir(@conmail), :notice => 'El mail fue actualizado correctamente.' }
        format.json { render json: @conmail, :notice => 'El mail fue actualizado correctamente.' }
      else
        #format.html { render :action => "edit" }
        format.json { render json: @mail.errors, :notice => 'error' }
      end

    end
  end

  # DELETE /mails/1
  # DELETE /mails/1.json
  def destroy
    @conmail = find_conmail
    @conmail.mail_internos.find(params[:id]).destroy

    respond_to do |format|
      format.html { head :ok}
      #format.json { head :ok }
    end
  end

  def redirigir conmail
    if @conmail.class.name == "Empresa"
      @idemp = @conmail.id.to_s
      @goto = "/empresas/"+@idemp

    elsif @conmail.class.name == "Persona"
      @idper = @conmail.id.to_s
      @goto = "/personas/"+@idper

    elsif @conmail.class.name == "Sucursal"
      @idene = @conmail.empresa.id.to_s
      @idenc = @conmail.id.to_s
      @goto = "/empresas/"+@idene+"/sucursals/"+@idenc

    elsif @conmail.class.name == "Contacto"
      if  @conmail.contactable.class.name == "Empresa"
        @idemp = @conmail.contactable.id.to_s
        @idcon = @conmail.id.to_s
        @goto = "/empresas/"+@idemp+"/contactos/"+@idcon
      elsif @conmail.contactable.class.name == "Sucursal"
        @idemp = @conmail.contactable.empresa.id.to_s
        @idsuc = @conmail.contactable.id.to_s
        @idcon = @conmail.id.to_s
        @goto = "/empresas/"+@idemp+"/sucursals/"+@idsuc+"/contactos/"+@idcon

      end
    elsif @conmail.class.name == "Tipocliente"
      @goto = "/tipoclientes/"+ @conmail.id.to_s
    end

    return @goto

  end


  def find_conmail
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

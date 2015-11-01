class RecibosController < ApplicationController

  before_filter :authenticate

  # GET /recibos
  # GET /recibos.json
  def index
    @comerciante = find_comerciante
    if (@comerciante)
      @recibos = @comerciante.recibos
    else
        if params[:filtro] != nil
          @recibos = Recibo.where("numero like '%" +params[:filtro] +"%'").paginate(:page => params[:numero_hoja],:order => 'fecha desc', :per_page => 18)
        else
          @recibos = Recibo.paginate(:page => params[:numero_hoja], :per_page => 18, :include => [:comerciante,:moneda,:renglon_recdetalles], :order => "updated_at DESC")
        end
    end
    if params[:numero_hoja].nil?
     respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @recibos }
    end
    else
       respond_to do |format|
        format.html   { render :layout => "application_paginate"}# index.html.erb# index.html.erb
        #format.json { render json: @impuestos }
      end
    end
  end

   def filtered
    @qcliente = "1=1"
    @qsucursal = "1=1"
    @qtipo = "1=1"
    @qdesde = "1=1"
    @qhasta = "1=1"
    @posible_id = "1=1"

    if params[:factura_id] != nil && params[:factura_id] != "-1"
      @posible_id = "id like '%" +params[:factura_id] +"%'"
    end
    if params[:sucursal] != nil && params[:sucursal] != "-1"
      @qsucursal = "sucursal_id like '%" +params[:sucursal] +"%'"
    end

    if params[:cliente] != nil && params[:cliente] != "-1"
      @qcliente = "comerciante_id = " + params[:cliente]
    end
    if params[:tipo] == "contado"
      @qtipo = "contado = true"
    else if  params[:tipo] == "credito"
        @qtipo = "contado = false"
      end
    end

    if params[:desde] != nil
      str   = params[:desde]
      regex = /\d{2}\/\d{2}\/\d{4}/

      if str =~ regex
        @date = Date.strptime(params[:desde],"%d/%m/%Y")
        @qdesde = "fecha >= \'" + @date.to_s("%Y-%m-%d")+"\'"
        # print 'matched', "\n"
      else
        #  print 'did not match', "\n"
      end

    end

    if params[:hasta] != nil
      str   = params[:hasta]
      regex = /\d{2}\/\d{2}\/\d{4}/

      if str =~ regex
        @date = Date.strptime(params[:hasta],"%d/%m/%Y")
        @qhasta = "fecha <= \'" + @date.to_s("%Y-%m-%d") +"\'"
        # print 'matched', "\n"
      else
        # print 'did not match', "\n"
      end


    end

    @recibos = Recibo.where(@qcliente+" and "+@qtipo+" and "+@qdesde + " and "+@qhasta + " and "+  @posible_id + " and "+ @qsucursal).paginate(:page => params[:numero_hoja], :per_page => 18,:order => 'updated_at DESC, fecha DESC')
    respond_to do |format|
      format.html { render :layout => "application_paginate"}
      format.json { render json: @recibos, :include => :renglon_facturas }
    end
  end

 
  # GET /recibos/1
  # GET /recibos/1.json
  def show
    @recibo = Recibo.find(params[:id])
    @renglon = @recibo.renglon_recibos;
    @result =  @recibo.to_json( :include => [ :renglon_recdetalles ,:comerciante,:renglon_recibo_docs  , :sucursal],:methods => [:total_sinimpuestos,:total_impuestos]);
    hash = JSON.parse(@result)

    hash["renglon_facturas"] = JSON.parse(@renglon.to_json(:methods => :nombrearticulo));
    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: hash.to_json()}
    end
  end

  # GET /recibos/new
  # GET /recibos/new.json
  def new
    @recibo = Recibo.new

    respond_to do |format|
      format.html { render :layout => 'special_form'}# new.html.erb
      #format.json { render json: @empresa }
    end
      
  end

  # GET /recibos/1/edit
  def edit
    @recibo = Recibo.find(params[:id])
    respond_to do |format|
      format.html { render :layout => 'special_form'}# new.html.erb
      #format.json { render json: @empresa }
    end
  end

  # POST /recibos
  # POST /recibos.json
  def create

    @comerciante = find_comerciante
    @recibo = @comerciante.recibos.build(params[:recibo])

    respond_to do |format|
      if @recibo.save
        format.html { redirect_to @recibo, notice => 'Recibo was successfully created.' }
        format.json { render json: @recibo, status: :created, location: @recibo }
      else
        format.html { render :action => "new" }
        format.json { render json: @recibo.errors }
      end
    end
  end

  # PUT /recibos/1
  # PUT /recibos/1.json
  def update
    @recibo = Recibo.find(params[:id])

#   if (params[:recibo][:factura_ids] == nil)
#      params[:recibo][:factura_ids] = []
#    end

    respond_to do |format|
      if @recibo.update_attributes(params[:recibo])
        format.html { redirect_to @recibo, notice => 'Recibo was successfully updated.' }
        format.json { render json: @recibo }
      else
        format.html { render :action => "edit" }
        format.json { render json: @recibo.errors }
      end
    end
  end

  # DELETE /recibos/1
  # DELETE /recibos/1.json
  def destroy
    @recibo = Recibo.find(params[:id])
    @recibo.destroy

    respond_to do |format|
      format.html { redirect_to recibos_url }
      #format.json { head :ok }
    end
  end


  def generar_impresion
    @recibo = Recibo.find(params[:id])
    if @recibo
      @recibo.imprimir(params[:serie],params[:numero])
      if @recibo.errors.count <= 0
        if @recibo.save
          respond_to do |format|
            format.json { render json: @recibo }
          end
        else
          respond_to do |format|
            format.json { render json: @recibo.errors }
          end
        end
      else
        respond_to do |format|
          format.json { render json: @recibo.errors }
        end
      end
    else
      respond_to do |format|
        format.html { redirect_to recibos_url }
      end
    end
  end


  def proximo_preimpreso
    @recibo = Recibo.find(params[:id])
    if @recibo.manual
      @result = ImpresionesRec.proximo_preimpreso()
    else
      @result = Impresione.proximo_preimpreso()
    end
    @serie = @result[0]
    @nro = @result[1]
    respond_to do |format|
      format.json { render json: {:serie => @serie, :numero => @nro} }
    end
  end

  def anular
    @factura = Recibo.find(params[:id])
    if @factura
      @factura.anular
      if @factura.save
        respond_to do |format|
          format.json { render json: @factura }
        end
      else
        respond_to do |format|
          format.json { render json: @factura.errors }
        end
      end

    else
      respond_to do |format|
        format.json { render json: {:error => "Recibo no encontrada"} }
      end
    end


  end


  private

  def find_comerciante
    params.each do |name, value|
      if name =~ /(.+)_id$/
        return $1.classify.constantize.find(value)
      end
    end
    nil
  end


end

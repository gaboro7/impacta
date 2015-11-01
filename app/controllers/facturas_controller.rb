class FacturasController < ApplicationController

  #before_filter :authenticate


  # GET /facturas
  # GET /facturas.json


  def index
    if params[:filtro] != nil
      @facturas = Factura.where("numero like '%" +params[:filtro] +"%'").paginate(:page => params[:numero_hoja],:order => 'updated_at DESC, fecha DESC', :per_page => 18)
    else
      @comerciante = find_comerciante
      if (@comerciante)
        @facturas = @comerciante.facturas.paginate(:page => params[:numero_hoja],:order => 'numero DESC', :per_page => 18, :include=> :comerciante, :include=> :moneda)
      else
        @facturas = Factura.paginate(:page => params[:numero_hoja],:order => 'updated_at DESC, fecha DESC', :per_page => 10, :include=> :comerciante, :include=> :moneda)
      end


    end
    if params[:numero_hoja].nil?
      respond_to do |format|
        format.html # index.html.erb
        format.json { render json: @facturas }
      end
    else
      respond_to do |format|
        format.html   { render :layout => "application_paginate"}# index.html.erb # index.html.erb
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
    @qadeudo = "1=1"
    @numero = "1=1"
    @adeudo = "1=1"

    if params[:adeudo] != nil && params[:adeudo] != "-1"
      @adeudo = "adeudo != 0"
    end

    if params[:factura_id] != nil && params[:factura_id] != "-1"
      @posible_id = "id like '%" +params[:factura_id] +"%'"
    end

    if params[:numero] != nil && params[:numero] != "-1"
      @numero = "numero like '%" +params[:numero] +"%'"
    end

    if params[:sucursal] != nil && params[:sucursal] != "-1"
      @qsucursal = "sucursal_id like '%" +params[:sucursal] +"%'"
    end

    if params[:cliente] != nil && params[:cliente] != "-1"
      @qcliente = "comerciante_id = " + params[:cliente]
    end

    if params[:tipo] == "contado"
      @qtipo = "contado = true"
    elsif  params[:tipo] == "credito"
        @qtipo = "contado = false"
    end

    if params[:adeudo] != nil
      if params[:adeudo] == "false"
        @qadeudo = "adeudo < 1 AND adeudo > -1"
      elsif params[:adeudo] == "true"
        @qadeudo = "adeudo > 1"
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

    @facturas = Factura.where(@qcliente+" and "+@qtipo+" and "+@qdesde + " and "+@qhasta + " and "+  @posible_id + " and "+ @qsucursal + " and " + @qadeudo+ " and " + @numero + " and " +@adeudo).paginate(:page => params[:numero_hoja], :per_page => 15)
    respond_to do |format|
      format.html { render :layout => "application_paginate"}
      format.json { render json: @facturas.as_json( :include => [:renglon_facturas,:moneda]) }
    end
  end



  # GET /facturas/1
  # GET /facturas/1.json
  def show
    @factura = Factura.find(params[:id])
    @renglon = @factura.renglon_facturas;
    @result =  @factura.to_json( :include => [ :renglon_factdetalles  ,:comerciante , :sucursal ,:moneda ],:methods => [:total_sinimpuestos,:total_impuestos]);
    hash = JSON.parse(@result)

    hash["renglon_facturas"] = JSON.parse(@renglon.to_json(:methods => :nombrearticulo));
 #   hash["total_impuestos"] = JSON.parse(@factura.to_json(:methods => :total_impuestos));
 #   hash["total_sin_impuestos"] = JSON.parse(@factura.to_json(:methods => :total_sinimpuestos));
  
    respond_to do |format|
        format.html # show.html.erb
        format.json { render json: hash.to_json()}
    end
  end
  # GET /facturas/new
  # GET /facturas/new.json
  def new
    @factura = Factura.new

    respond_to do |format|
      format.html { render :layout => 'special_form'}# new.html.erb
      #format.json { render json: @factura }
    end
  end

  # GET /facturas/1/edit
  def edit
    @factura = Factura.find(params[:id])
    @total_impuestos = @factura.total_impuestos
    @total_sinimpuestos = @factura.total_sinimpuestos
    @subtotal =  @factura.subtotal

    if (@factura.impresa?)
      @recibos_renglon = RenglonRecibo.includes(:recibo).where(:factura_id => params[:id] )
      @recibos_recdetealle = RenglonRecdetalle.includes(:recibo).where(:factura_id => params[:id] )
      @recibos_notacredito = RenglonNotacredito.includes(:notadecredito).where("factura_id = "+params[:id].to_s )
      @recibos_notadebito = RenglonNotadebito.includes(:notadedebito).where("factura_id = "+params[:id].to_s )
    else
      @recibos_renglon = nil
      @recibos_recdetealle = nil
      @recibos_notacredito = nil
      @recibos_notadebito  = nil
    end
    respond_to do |format|
      format.html { render :layout => 'special_form'}# new.html.erb
      #format.json { render json: @factura }
    end
  end

  # POST /facturas
  # POST /facturas.json
  def create
    @comerciante = find_comerciante
    @factura = @comerciante.facturas.build(params[:factura])

    respond_to do |format|
      if @factura.save
        format.html { redirect_to @factura, :notice => 'Factura was successfully created.' }
        format.json { render json: @factura, status: :created, location: @factura }
      else
        format.html { render :action => "new" }
        format.json { render json: @factura.errors }
      end
    end
  end

  # PUT /facturas/1
  # PUT /facturas/1.json
  def update
    @factura = Factura.find(params[:id])
    @factura.cambio_moneda = 0

    if @factura.moneda.id.to_s != params[:factura][:moneda_id]
      @factura.cambio_moneda = @factura.moneda.tipodecambio
    end

    respond_to do |format|
      if @factura.update_attributes(params[:factura])
        format.html { redirect_to @factura, :notice => 'Factura was successfully updated.' }
        format.json { render json: @factura }
      else
        format.html { render :action => "edit" }
        format.json { render json: @factura.errors }
      end
    end
  end

  # DELETE /facturas/1
  # DELETE /facturas/1.json
  def destroy
    @factura = Factura.find(params[:id])
    if @factura.destroy
      respond_to do |format|
        format.html { head :ok }
        format.json { head :ok }
      end
    else
      respond_to do |format|
        format.json { render json: @factura.errors }
      end
    end

    
  end

  def generar_impresion
    @factura = Factura.find(params[:id])
    if @factura
      @factura.imprimir(params[:serie],params[:numero])
      if @factura.errors.count <= 0
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
          format.json { render json: @factura.errors }
        end
      end
    else
      respond_to do |format|
        format.html { redirect_to facturas_url }
      end
    end
  end


  def proximo_preimpreso

    @result = Impresione.proximo_preimpreso()
    @serie = @result[0]
    @nro = @result[1]
    respond_to do |format|
      format.json { render json: {:serie => @serie, :numero => @nro} }
    end

  end

  def anular
    @factura = Factura.find(params[:id])
    if @factura
      @factura.anular
      if @factura.errors.count <= 0
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
          format.json { render json: @factura.errors }
        end
      end

    else
      respond_to do |format|
        format.json { render json: {:error => "Factura no encontrada"} }
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

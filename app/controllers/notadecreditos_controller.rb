class NotadecreditosController < ApplicationController

  #before_filter :authenticate

  # GET /notadecreditos
  # GET /notadecreditos.json
  def index
    if params[:filtro] != nil
      if params[:tipo] != nil
        @notadecreditos = Notadecredito.where("numero like '%" +params[:filtro] +"%'").paginate(:conditions  => 'es_devolucion = 1' ,:page => params[:numero_hoja],:order => 'fecha desc', :per_page => 18)
      else
         @notadecreditos = Notadecredito.where("numero like '%" +params[:filtro] +"%'").paginate(:conditions  => 'es_devolucion = 0',:page => params[:numero_hoja],:order => 'fecha desc', :per_page => 18)
     end
    else
      if params[:tipo] != nil
         @notadecreditos = Notadecredito.paginate(:page => params[:numero_hoja],:conditions  => 'es_devolucion = 1' ,:order => 'fecha desc', :per_page => 15, :include=> :comerciante, :include=> :moneda)
      else
         @notadecreditos = Notadecredito.paginate(:page => params[:numero_hoja],:conditions  => 'es_devolucion = 0',:order => "updated_at DESC", :per_page => 15, :include=> :comerciante, :include=> :moneda)
      end
     
    end
    if params[:numero_hoja].nil?
      respond_to do |format|
        format.html # index.html.erb
        format.json { render json: @notadecreditos }
      end
    else
      respond_to do |format|
        format.html   { render :layout => "application_paginate"}# index.html.erb
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
    @tipo = "es_devolucion = 0"
    if params[:tipo] != nil && params[:tipo] != "-1"
      @tipo = "es_devolucion = 1"
    end
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

    @notadecreditos = Notadecredito.where(@qcliente+" and "+@qtipo+" and "+@qdesde + " and "+@qhasta + " and "+  @posible_id + " and "+ @qsucursal + " and " +@tipo).paginate(:page => params[:numero_hoja], :per_page => 18,:order => 'updated_at DESC, fecha DESC')
    respond_to do |format|
      format.html { render :layout => "application_paginate"}
      format.json { render json: @notadecreditos, :include => :renglon_facturas }
    end
  end

  # GET /notadecreditos/1
  # GET /notadecreditos/1.json
  def show
    @notadecredito = Notadecredito.find(params[:id])
    @renglon = @notadecredito.renglon_notacreditos
    @renglon_art = @notadecredito.renglon_ndc_articulos
    @renglon_ndcndds = @notadecredito.renglon_ndcndds
    @result =  @notadecredito.to_json( :include => [ :renglon_ndcdetalles  ,:comerciante , :sucursal ],:methods => [:total_sinimpuestos,:total_impuestos])
    hash = JSON.parse(@result)

    hash["renglon_facturas"] = JSON.parse(@renglon.to_json(:methods => [:nombrearticulo , :numero]))
    hash["renglon_ndc_articulos"] = JSON.parse(@renglon_art.to_json(:methods => :nombrearticulo))
    hash["renglon_ndcndds"] = JSON.parse(@renglon_ndcndds.to_json(:methods => :nombrearticulo))
    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: hash.to_json()}
    end
  end

  # GET /notadecreditos/new
  # GET /notadecreditos/new.json
  def new
    @notadecredito = Notadecredito.new

    respond_to do |format|
      format.html  { render :layout => 'special_form'}
      format.json { render json: @notadecredito }
    end
  end

  # GET /notadecreditos/1/edit
  def edit
    @notadecredito = Notadecredito.find(params[:id])
    @total_impuestos = @notadecredito.total_impuestos
    @total_sinimpuestos = @notadecredito.total_sinimpuestos
    @subtotal =  @notadecredito.subtotal

    if(@notadecredito.impresa?)
      @renglon_notadedebito = RenglonNddndc.includes(:notadedebito).where("notadecredito_id = "+params[:id].to_s )
    else
      @renglon_notadedebito = nil
    end
     respond_to do |format|
      format.html  { render :layout => 'special_form'}
      format.json { render json: @notadecredito }
    end
  end

  # POST /notadecreditos
  # POST /notadecreditos.json
  def create
    @comerciante = find_comerciante
    @notadecredito = @comerciante.notadecreditos.build(params[:notadecredito])

    respond_to do |format|
      if @notadecredito.save
        format.html { redirect_to @notadecredito, notice: 'Notadecredito was successfully created.' }
        format.json { render json: @notadecredito}
      else
        format.html { render action: "new" }
        format.json { render json: @notadecredito.errors}
      end
    end
  end

  # PUT /notadecreditos/1
  # PUT /notadecreditos/1.json
  def update
    @notadecredito = Notadecredito.find(params[:id])

    respond_to do |format|
      if @notadecredito.update_attributes(params[:notadecredito])
        format.html { redirect_to @notadecredito, notice: 'Notadecredito was successfully updated.' }
        format.json { render json: @notadecredito }
      else
        format.html { render action: "edit" }
        format.json { render json: @notadecredito.errors}
      end
    end
  end

  # DELETE /notadecreditos/1
  # DELETE /notadecreditos/1.json
  def destroy
    @notadecredito = Notadecredito.find(params[:id])
    @notadecredito.destroy

    respond_to do |format|
      format.html { redirect_to notadecreditos_url }
      format.json { head :ok }
    end
  end

  def generar_impresion
    @notadecredito = Notadecredito.find(params[:id])
    if @notadecredito
      @notadecredito.imprimir(params[:serie],params[:numero])
      if @notadecredito.errors.count <= 0
        if @notadecredito.save
          respond_to do |format|
            format.json { render json: @notadecredito }
          end
        else
          respond_to do |format|
            format.json { render json: @notadecredito.errors }
          end
        end
      else
        respond_to do |format|
          format.json { render json: @notadecredito.errors }
        end
      end
    else
      respond_to do |format|
        format.html { redirect_to notadecreditos_url }
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
    @notadecredito = Notadecredito.find(params[:id])
    if @notadecredito
      @notadecredito.anular
      if @notadecredito.save
        respond_to do |format|
          format.json { render json: @notadecredito }
        end
      else
        respond_to do |format|
          format.html { redirect_to notadecreditos_url }
        end
      end

    else
      respond_to do |format|
        format.html { redirect_to notadecreditos_url }
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

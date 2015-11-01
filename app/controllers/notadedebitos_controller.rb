class NotadedebitosController < ApplicationController

  before_filter :authenticate

  # GET /notadedebitos
  # GET /notadedebitos.json
  def index
     if params[:filtro] != nil
      @notadedebitos = Notadedebito.where("id like '%" +params[:filtro] +"%'").paginate(:page => params[:numero_hoja], :order => 'updated_at DESC, fecha DESC', :per_page => 18)
    else
      @notadedebitos = Notadedebito.paginate(:page => params[:numero_hoja], :order => 'updated_at DESC, fecha DESC', :per_page => 15, :include=> :comerciante)
    end
    if params[:numero_hoja].nil?
      respond_to do |format|
        format.html # index.html.erb
        format.json { render json: @notadedebitos }
      end
     else
      respond_to do |format|
        format.html  { render :layout => 'special_form'} # index.html.erb
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

    @notadedebitos = Notadedebito.where(@qcliente+" and "+@qtipo+" and "+@qdesde + " and "+@qhasta + " and "+  @posible_id + " and "+ @qsucursal).paginate(:page => params[:numero_hoja], :per_page => 18)
    respond_to do |format|
      format.html { render :layout => "application_paginate"}
      format.json { render json: @notadedebitos, :include => :renglon_facturas }
    end
  end

  # GET /notadedebitos/1
  # GET /notadedebitos/1.json
  def show
    @notadedebito = Notadedebito.find(params[:id])
    @renglon = @notadedebito.renglon_notadebitos;
    @result =  @notadedebito.to_json( :include => [ :renglon_ndddetalles,:renglon_nddndcs  ,:comerciante ],:methods => [:total_sinimpuestos,:total_impuestos]);
    hash = JSON.parse(@result)

    hash["renglon_facturas"] = JSON.parse(@renglon.to_json(:methods => :nombrearticulo));
    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: hash.to_json()}
    end
  end

  # GET /notadedebitos/new
  # GET /notadedebitos/new.json
  def new
    @notadedebito = Notadedebito.new
    respond_to do |format|
      format.html { render :layout => 'special_form'}# new.html.erb
      format.json { render json: @notadedebito }
    end
   
  end

  # GET /notadedebitos/1/edit
  def edit
    @notadedebito = Notadedebito.find(params[:id])
    if(@notadedebito.impresa?)
      @renglon_notadecredito = RenglonNdcndd.includes(:notadecredito).where("notadedebito_id = "+params[:id].to_s )
    else
      @renglon_notadecredito = nil
    end
    respond_to do |format|
      format.html { render :layout => 'special_form'}# new.html.erb
      format.json { render json: @notadedebito }
    end
  end

  # POST /notadedebitos
  # POST /notadedebitos.json
  def create
    @comerciante = find_comerciante
    @notadedebito = @comerciante.notadedebitos.create(params[:notadedebito])

    respond_to do |format|
      if @notadedebito.save
        format.html { redirect_to @notadedebito, notice: 'Notadedebito was successfully created.' }
        format.json { render json: @notadedebito}
      else
        format.html { render action: "new" }
        format.json { render json: @notadedebito.errors }
      end
    end
  end

  # PUT /notadedebitos/1
  # PUT /notadedebitos/1.json
  def update
    @notadedebito = Notadedebito.find(params[:id])

    respond_to do |format|
      if @notadedebito.update_attributes(params[:notadedebito])
        format.html { redirect_to @notadedebito, notice: 'Notadedebito was successfully updated.' }
        format.json { render json: @notadedebito }
      else
        format.html { render action: "edit" }
        format.json { render json: @notadedebito.errors}
      end
    end
  end

  # DELETE /notadedebitos/1
  # DELETE /notadedebitos/1.json
  def destroy
    @notadedebito = Notadedebito.find(params[:id])
    if @notadedebito.destroy

      respond_to do |format|
        format.html { head :ok }
        format.json { head :ok }
      end
    else
      format.html { redirect_to notadedebitos_url }
      format.json { render json: @notadedebito.errors}
    end
  end


def generar_impresion
    @notadededito = Notadedebito.find(params[:id])
    if @notadededito
      @notadededito.imprimir(params[:serie],params[:numero])
      if @notadededito.save
        respond_to do |format|
          format.json { render json: @notadededito }
        end
      else
        respond_to do |format|
          format.json { render json: @notadededito.errors }
        end
      end
    else
      respond_to do |format|
        format.html { redirect_to notadededitos_url }
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
    @notadecredito = Notadededito.find(params[:id])
    if @notadededito
      @notadededito.anular
      if @notadededito.save
        respond_to do |format|
          format.json { render json: @notadededito }
        end
      else
        respond_to do |format|
          format.html { redirect_to notadededitos_url }
        end
      end

    else
      respond_to do |format|
        format.html { redirect_to notadededitos_url }
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

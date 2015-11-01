class EmpresasController < ApplicationController

  before_filter :authenticate

  # GET /empresas
  # GET /empresas.json
  def index
    if params[:filtro] != nil
      if params[:tipo] == nil
        @contado =  (params[:contado] != nil && params[:contado] != "1")?"credito = " + (params[:contado]=="0").to_s: "1=1";

        @empresas = Empresa.where("(upper(nombre) like upper('%" +params[:filtro] +"%') or id like '%" +params[:filtro] +"%' ) and " +@contado)
        @sucursales = Sucursal.where("(upper(nombre) like upper('%" +params[:filtro] +"%') or id like '%" + params[:filtro] + "%' )" + ((params[:contado] != nil && params[:contado] != "1")?"" : " and empresa_id in (SELECT id from clientes where " +@contado +")" ))
        @personas = Persona.where("upper(nombre) like upper('%" +params[:filtro] +"%') or id like '%" +params[:filtro] +"%' and " +@contado)

      else
        case params[:tipo]
          when "empresa"
            @empresas = Empresa.where("upper(nombre) like upper('%" +params[:filtro] +"%') or id like '%" +params[:filtro] +"%' )")
            @personas = Persona.where("upper(nombre) like upper('%" +params[:filtro] +"%') or id like '%" +params[:filtro] +"%' )")
            respond_to do |format|
              format.html # index.html.erb
              format.json { render json:  { :empresas => @empresas.as_json(:include => :mail_internos) , :personas => @personas.as_json(:include => :mail_internos)  }}
            end
            return 0
          when "sucursal"
            @sucursals = Sucursal.where("upper(nombre) like upper('%" +params[:filtro] +"%') or id like '%" +params[:filtro] +"%' )")
            respond_to do |format|
              format.html # index.html.erb
              format.json { render json:  { :sucursal =>  @sucursals.as_json(:include => :mail_internos)  }}
            end
            return 0
          when "grupo"
            #@grupos = Tipocliente.where("upper(nombre) like upper('%" +params[:filtro] +"%')").includes(:mail_internos).inludes(:mail)
            @grupos = Tipocliente.find(:all, :conditions => "upper(nombre) like upper('%" +params[:filtro] +"%')" )
            respond_to do |format|
              format.html # index.html.erb
              format.json { render json:  { :grupos =>  @grupos.as_json(:include => :mail_internos)}}
            end
            return 0
        end

      end
    else
      @empresas = Empresa.paginate(:page => params[:numero_hoja], :per_page => 15)

    end

    if params[:numero_hoja].nil?
      respond_to do |format|
        format.html # index.html.erb
        if (@empresas != nil)
          @empresas.each do |ra|
            ra["tipo"] = "Empresa"
          end
        end
        if (@sucursales != nil)
          @sucursales.each do |ra|
            ra["tipo"] = "Sucursal"
          end
        end
        if (@personas != nil)
          @personas.each do |ra|
            ra["tipo"] = "Persona"
          end
        end
        format.json { render json:  { :empresas => @empresas.as_json(:include => :mail_internos) , :sucursales=> @sucursales.as_json(:include => [:empresa,:mail_internos]),:personas => @personas.as_json(:include => :mail_internos) }}
      end
    else
      respond_to do |format|
        format.html  { render :layout => "application_paginate"}# index.html.erb
                                                                #format.json { render json: @impuestos }
      end
    end
  end

  # GET /empresas/1
  # GET /empresas/1.json
  def show
    @empresa = Empresa.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @empresa }
    end
  end

  # GET /empresas/new
  # GET /empresas/new.json
  def new
    @empresa = Empresa.new
    respond_to do |format|
      format.html { render :layout => 'special_form'}# new.html.erb
                                                     #format.json { render json: @empresa }
    end
  end

  # GET /empresas/1/edit
  def edit
    @empresa = Empresa.find(params[:id])
    @cliente = @empresa
    respond_to do |format|
      format.html { render :layout => 'special_form'}# new.html.erb
                                                     #format.json { render json: @empresa }
    end
  end

  # POST /empresas
  # POST /empresas.json
  def create

    @empresa = Empresa.new(params[:empresa])

    respond_to do |format|
      if @empresa.save
        format.html { redirect_to @empresa, :notice => 'Empresa was successfully created.' }
        format.json { render json: @empresa, status: :created, location: @empresa }
      else
        format.html { render :action => "new" }
        format.json { render json: @empresa.errors }
      end
    end
  end

  # PUT /empresas/1
  # PUT /empresas/1.json
  def update
    @empresa = Empresa.find(params[:id])

    respond_to do |format|
      if @empresa.update_attributes(params[:empresa])
        format.html { redirect_to @empresa, :notice => 'Empresa was successfully updated.' }
        format.json { render json: @empresa }
      else
        format.html { render :action => "edit" }
        format.json { render json: @empresa.errors }
      end
    end
  end

  # DELETE /empresas/1
  # DELETE /empresas/1.json
  def destroy
    @empresa = Empresa.find(params[:id])
    @empresa.destroy

    respond_to do |format|
      format.html { redirect_to empresas_url }
      #format.json { head :ok }
    end
  end
end

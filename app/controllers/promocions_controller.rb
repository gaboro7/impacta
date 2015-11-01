class PromocionsController < ApplicationController

  before_filter :authenticate

  # GET /promocions
  # GET /promocions.json
  def index
    if(!params[:filtro].nil?)
       @promocions = Promocion.where("descripcion like '%" +params[:filtro] +"%'").paginate( :per_page => 18,:page => 1)
    else
     @promocions = Promocion.paginate(:page => params[:numero_hoja], :per_page => 18)
    end
    if params[:numero_hoja].nil?
      respond_to do |format|
        format.html # index.html.erb
        format.json { render json: @promocions }
      end
    else
      respond_to do |format|
        format.html  { render :layout => "application_paginate"}
        format.json { render json: @promocions }
      end
    end
  end

  # GET /promocions/1
  # GET /promocions/1.json
  def show
    @promocion = Promocion.find(params[:id])
   
    respond_to do |format|
      format.html # show.html.erb
      #format.json { render json: @promocion }
    end
  end

  # GET /promocions/new
  # GET /promocions/new.json
  def new
    @promocion = Promocion.new

    respond_to do |format|
      format.html { render :layout => 'special_form'}# new.html.erb
      #format.json { render json: @promocion }
    end
  end

  # GET /promocions/1/edit
  def edit
    @promocion = Promocion.find(params[:id])
    
    respond_to do |format|
      format.html { render :layout => 'special_form'}# new.html.erb
      #format.json { render json: @promocion }
    end
  end

  # POST /promocions
  # POST /promocions.json
  def create
    @promocion = Promocion.new(params[:promocion])

    respond_to do |format|
      if @promocion.save
        format.html { redirect_to @promocion, :notice => 'Promocion was successfully created.' }
        format.json { render json: @promocion, status: :created, location: @promocion }
      else
        format.html { render :action => "new" }
        format.json { render json: @promocion.errors }
      end
    end
  end

  # PUT /promocions/1
  # PUT /promocions/1.json
  def update
    @promocion = Promocion.find(params[:id])
     logger.debug "-------------------------------------------------------"
     logger.debug  params[:promocion][:formadepago_ids]
     logger.debug "-------------------------------------------------------"
    if (params[:promocion][:comercializable_ids] == nil)
      params[:promocion][:comercializable_ids] = []
    end

    if (params[:promocion][:formadepago_ids] == nil)
      params[:promocion][:formadepago_ids] = []
    end

    respond_to do |format|
      if @promocion.update_attributes(params[:promocion])
        format.html { redirect_to @promocion, :notice => 'Promocion was successfully updated.' }
        format.json { render json: @promocion}
      else
        format.html { render :action => "edit" }
        format.json { render json: @promocion.errors }
      end
    end
  end

  # DELETE /promocions/1
  # DELETE /promocions/1.json
  def destroy
    @promocion = Promocion.find(params[:id])
    @promocion.destroy

    respond_to do |format|
      format.html { redirect_to promocions_url }
      #format.json { head :ok }
    end
  end
end

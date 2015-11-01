class PrecioartsController < ApplicationController

  before_filter :authenticate

  # GET /precioarts
  # GET /precioarts.json
  def index
    @listaprecio = Listaprecio.find(params[:listaprecio_id])
    @precioarts = @listaprecio.precioarts

    respond_to do |format|
      format.html # index.html.erb
      #format.json { render json: @precioarts }
    end
  end

  # GET /precioarts/1
  # GET /precioarts/1.json
  def show
    @listaprecio = Listaprecio.find(params[:listaprecio_id])
    @precioarts = @listaprecio.precioarts.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      #format.json { render json: @precioart }
    end
  end

  # GET /precioarts/new
  # GET /precioarts/new.json
  def new
    @precioart = Precioart.new

    respond_to do |format|
      format.html { render :layout => 'special_form'}# new.html.erb
     #format.json { render json: @precioart }
    end
  end

  # GET /precioarts/1/edit
  def edit
    @listaprecio = Listaprecio.find(params[:listaprecio_id])
    @precioarts = @listaprecio.precioarts.find(params[:id])
    respond_to do |format|
      format.html { render :layout => 'special_form'}# new.html.erb
      #format.json { render json: @precioarts }
    end
  end

  # POST /precioarts
  # POST /precioarts.json
  def create
    @listaprecio = Listaprecio.find(params[:listaprecio_id])
    @precioarts = @listaprecio.precioarts.create(params[:precioart])

    respond_to do |format|
      if @precioarts.save
        format.html { redirect_to edit_listaprecio_path(@listaprecio), :notice => 'Precioart was successfully created.' }
        format.json { render json: @precioarts }
      else
        format.html { render :action => "new" }
        format.json { render json: @precioarts.errors }
      end
    end
  end

  # PUT /precioarts/1
  # PUT /precioarts/1.json
  def update
    @listaprecio = Listaprecio.find(params[:listaprecio_id])
    @precioarts = @listaprecio.precioarts.find(params[:id])
    
    respond_to do |format|
      if @precioarts.update_attributes(params[:precioart])
        if (params[:com].to_s == "true")
            format.html { redirect_to @precioarts, :notice => 'Precioart was successfully.' }
            format.json { render json: @precioart }
        else
           format.html { redirect_to edit_listaprecio_path(@listaprecio), :notice => 'Precioart was successfully updated.' }
           format.json { render json: @listaprecio }
        end        
        
      else
        format.html { render :action => "edit" }
        format.json { render json: @precioarts.errors}
      end
    end
  end

  # DELETE /precioarts/1
  # DELETE /precioarts/1.json
  def destroy
    @listaprecio = Listaprecio.find(params[:listaprecio_id])
    @precioarts = @listaprecio.precioarts.find(params[:id]).destroy

    respond_to do |format|
      format.html { redirect_to edit_listaprecio_path(@listaprecio)}
      #format.json { head :ok }
    end
  end
  
 end

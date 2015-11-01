class ComercializablesController < ApplicationController

  before_filter :authenticate

  # GET /comercializables
  # GET /comercializables.json
  def index
    @rola = find_rola
    @comercializables = @rola.rolarticulos.where(:type => 'Comercializable')

    respond_to do |format|
      format.html # show.html.erb
      #format.json { render json: @comercializable }
    end
  end

  # GET /comercializables/new
  # GET /comercializables/new.json
  def new
    @comercializable = Comercializable.new

    respond_to do |format|
      format.html { render :layout => 'special_form'}# new.html.erb
      #format.json { render json: @comercializable }
    end
  end

  # GET /comercializables/1/edit
  def edit
    @rola = find_rola
    @comercializable = @rola.rolarticulos.find(params[:id])

    respond_to do |format|
      format.html { render :layout => 'special_form'}# new.html.erb
      #format.json { render json: @empresa }
    end

  end

  # POST /comercializables
  # POST /comercializables.json
  def create    
    @rola = find_rola
    @comercializable = Comercializable.new(params[:comercializable])    
    @rola.rolarticulos << @comercializable
    #@comercializable.rola_type = @rola.class.name
    respond_to do |format|
      if @comercializable.save        
        format.html { redirect_to @rola, :notice => 'Comercializable was successfully created.' }
        format.json { render json: @rola, status: :created, location: @comercializable }
      else
        format.html { render :action => "new" }
        format.json { render json: @rola.errors }
      end
    end
  end

  # PUT /comercializables/1
  # PUT /comercializables/1.json
  def update
    @rola = find_rola

    if (params[:comercializable][:impuesto_ids] == nil)
      params[:comercializable][:impuesto_ids] = []
    end

    if (params[:comercializable][:promocion_ids] == nil)
      params[:comercializable][:promocion_ids] = []
    end
    @come = @rola.rolarticulos.find(params[:id])

    respond_to do |format|
      if @come.update_attributes(params[:comercializable])
        format.html { redirect_to @rola, :notice => 'Comercializable was successfully updated.' }
        format.json { render json: @rola }
      else
        format.html { render :action => "edit" }
        format.json { render json: @come.errors }
      end
    end
  end

  # DELETE /comercializables/1
  # DELETE /comercializables/1.json
  def destroy
    @rola = find_rola
    @rola.rolarticulos.find(params[:id]).destroy

    respond_to do |format|
      format.html { redirect_to @rola }
      #format.json { head :ok }
    end
  end
  
  
  private
  
  def find_rola
    params.each do |name, value|
      if name =~ /(.+)_id$/
        return $1.classify.constantize.find(value)
      end
    end
    nil
  end
  
end

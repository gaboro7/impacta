class RenglonNdddetallesController < ApplicationController


  before_filter :authenticate


  # GET /renglon_ndddetalles
  # GET /renglon_ndddetalles.json
  def index
    @notadedebito = Notadedebito.find(params[:notadedebito_id])
    @renglon_ndddetalles = @notadedebito.renglon_ndddetalles

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @renglon_ndddetalles }
    end
  end

  # GET /renglon_ndddetalles/1
  # GET /renglon_ndddetalles/1.json
  def show
    @notadedebito = Notadedebito.find(params[:notadedebito_id])
    @renglon_ndddetalles = @notadedebito.renglon_ndddetalles.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @renglon_ndddetalle }
    end
  end

  # GET /renglon_ndddetalles/new
  # GET /renglon_ndddetalles/new.json
  def new
    @renglon_ndddetalle = RenglonNdddetalle.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @renglon_ndddetalle }
    end
  end

  # GET /renglon_ndddetalles/1/edit
  def edit
    @notadedebito = Notadedebito.find(params[:notadedebito_id])
    @renglon_ndddetalles = @notadedebito.renglon_ndddetalles.find(params[:id])
    respond_to do |format|
      format.html { render json: @renglon_ndddetalles}# new.html.erb
    end
  end

  # POST /renglon_ndddetalles
  # POST /renglon_ndddetalles.json
  def create

    @notadedebito = Notadedebito.find(params[:notadedebito_id])
    @renglon_ndddetalle = @notadedebito.renglon_ndddetalles.create(params[:renglon_ndddetalle])

    respond_to do |format|
      if @renglon_ndddetalle.save
        format.html { redirect_to @notadedebito, notice: 'Renglon ndddetalle was successfully created.' }
        format.json { render json: @renglon_ndddetalle }
      else
        format.html { render action: "new" }
        format.json { render json: @renglon_ndddetalle.errors }
      end
    end
  end

  # PUT /renglon_ndddetalles/1
  # PUT /renglon_ndddetalles/1.json
  def update
    @notadedebito = Notadedebito.find(params[:notadedebito_id])
    @renglon_ndddetalles = @notadedebito.renglon_ndddetalles.find(params[:id])

    respond_to do |format|
      if @renglon_ndddetalle.update_attributes(params[:renglon_ndddetalle])
        format.html { redirect_to @renglon_ndddetalle, notice: 'Renglon ndddetalle was successfully updated.' }
        format.json {  render json: @renglon_ndddetalle }
      else
        format.html { render action: "edit" }
        format.json { render json: @renglon_ndddetalle.errors }
      end
    end
  end

  # DELETE /renglon_ndddetalles/1
  # DELETE /renglon_ndddetalles/1.json
  def destroy

    @notadedebito = Notadedebito.find(params[:notadedebito_id])
    @renglon_ndddetalles = @notadedebito.renglon_ndddetalles.find(params[:id]).destroy

    respond_to do |format|
      format.html { redirect_to notadedebito_url }
      format.json { head :ok }
    end
  end
end

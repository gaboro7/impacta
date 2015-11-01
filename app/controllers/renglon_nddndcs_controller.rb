class RenglonNddndcsController < ApplicationController

  before_filter :authenticate

  # GET /renglon_nddndcs
  # GET /renglon_nddndcs.json
  def index
    @notadedebito = Notadedebito.find(params[:notadedebito_id])
    @renglon_nddndcs = @notadedebito.renglon_nddndcs

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @renglon_nddndcs }
    end
  end

  # GET /renglon_nddndcs/1
  # GET /renglon_nddndcs/1.json
  def show
    @notadedebito = Notadedebito.find(params[:notadedebito_id])
    @renglon_nddndc = @notadedebito.renglon_nddndcs.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @renglon_nddndc }
    end
  end

  # GET /renglon_nddndcs/new
  # GET /renglon_nddndcs/new.json
  def new
    @renglon_nddndc = Renglonnddndd.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @renglon_nddndc }
    end
  end

  # GET /renglon_nddndcs/1/edit
  def edit
    @notadedebito = Notadedebito.find(params[:notadedebito_id])
    @renglon_nddndc = @notadedebito.renglon_nddndcs.find(params[:id])
    respond_to do |format|
      format.html { render :layout => 'special_form'}# new.html.erb
    end


  end

  # POST /renglon_nddndcs
  # POST /renglon_nddndcs.json
  def create

    @notadedebito = Notadedebito.find(params[:notadedebito_id])
    @renglon_nddndc = @notadedebito.renglon_nddndcs.create(params[:renglon_nddndc])

    respond_to do |format|
      if @renglon_nddndc.save
        format.html { redirect_to @notadedebito, notice: 'Renglon ndddetalle was successfully created.' }
        format.json { render json: @renglon_nddndc}
      else
        format.html { render action: "new" }
        format.json { render json: @renglon_nddndc.errors}
      end
    end
  end

  # PUT /renglon_nddndcs/1
  # PUT /renglon_nddndcs/1.json
  def update
    @notadedebito = Notadedebito.find(params[:notadedebito_id])
    @renglon_nddndc = @notadedebito.renglon_nddndcs.find(params[:id])

    respond_to do |format|
      if @renglon_nddndc.update_attributes(params[:renglon_nddndc])
        format.html { redirect_to @renglon_nddndc, notice: 'Renglon ndddetalle was successfully updated.' }
        format.json { render json: @renglon_nddndc }
      else
        format.html { render action: "edit" }
        format.json { render json: @renglon_nddndc.errors}
      end
    end
  end

  # DELETE /renglon_nddndcs/1
  # DELETE /renglon_nddndcs/1.json
  def destroy

    @notadedebito = Notadedebito.find(params[:notadedebito_id])
    @renglon_nddndc = @notadedebito.renglon_nddndcs.find(params[:id]).destroy

    respond_to do |format|
      format.html { head :ok  }
      format.json { head :ok }
    end
  end
end

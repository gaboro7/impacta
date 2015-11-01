class RenglonNotadebitosController < ApplicationController

  before_filter :authenticate

  # GET /renglon_notadebitos
  # GET /renglon_notadebitos.json
  def index
    @notadedebito = Notadedebito.find(params[:notadecredito_id])
    @renglon_notadebitos = @notadedebito.renglon_notadebitos

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @renglon_notadebitos }
    end
  end

  # GET /renglon_notadebitos/1
  # GET /renglon_notadebitos/1.json
  def show
    @notadedebito = Notadedebito.find(params[:notadecredito_id])
    @renglon_notadebito = @notadedebito.renglon_notadebitos.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @renglon_notadebito }
    end
  end

  # GET /renglon_notadebitos/new
  # GET /renglon_notadebitos/new.json
  def new
    @renglon_notadebito = RenglonNotadebito.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @renglon_notadebito }
    end
  end

  # GET /renglon_notadebitos/1/edit
  def edit
    @notadedebito = Notadedebito.find(params[:notadedebito_id])
    @renglon_notadebito = @notadedebito.renglon_notadebitos.find(params[:id])
    respond_to do |format|
      format.html { render :layout => 'special_form'}# new.html.erb
    end
  end

  # POST /renglon_notadebitos
  # POST /renglon_notadebitos.json
  def create
    @notadedebito = Notadedebito.find(params[:notadedebito_id])
    @renglon_notadebito = @notadedebito.renglon_notadebitos.create(params[:renglon_notadebito])

    respond_to do |format|
      if @renglon_notadebito.save
        format.html { redirect_to @notadebito, notice: 'Renglon notadebito was successfully created.' }
        format.json { render json: @renglon_notadebito}
      else
        format.html { render action: "new" }
        format.json { render json: @renglon_notadebito.errors}
      end
    end
  end

  # PUT /renglon_notadebitos/1
  # PUT /renglon_notadebitos/1.json
  def update
    @notadedebito = Notadedebito.find(params[:notadedebito_id])
    @renglon_notadebito = @notadedebito.renglon_notadebitos.find(params[:id])

    respond_to do |format|
      if @renglon_notadebito.update_attributes(params[:renglon_notadebito])
        format.html { redirect_to @notadebito, notice: 'Renglon notadebito was successfully updated.' }
        format.json { render json: @renglon_notadebito }
      else
        format.html { render action: "edit" }
        format.json { render json: @renglon_notadebito.errors}
      end
    end
  end

  # DELETE /renglon_notadebitos/1
  # DELETE /renglon_notadebitos/1.json
  def destroy
    @notadedebito = Notadedebito.find(params[:notadedebito_id])
    @renglon_notadebito = @notadedebito.renglon_notadebitos.find(params[:id]).destroy

    respond_to do |format|
      format.html { redirect_to notadedebitos_url }
      format.json { head :ok }
    end
  end
end

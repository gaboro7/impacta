class FormadepagosController < ApplicationController

  before_filter :authenticate

  # GET /formadepagos
  # GET /formadepagos.json
  def index
    @formadepagos = Formadepago.all(:include => :moneda)

    respond_to do |format|
      format.html # index.html.erb
      #format.json { render json: @formadepagos }
    end
  end

  # GET /formadepagos/1
  # GET /formadepagos/1.json
  def show
    @formadepago = Formadepago.find(params[:id],:include => :moneda)

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @formadepago }
    end
  end

  # GET /formadepagos/new
  # GET /formadepagos/new.json
  def new
    @formadepago = Formadepago.new

    respond_to do |format|
      format.html # new.html.erb
      #format.json { render json: @formadepago }
    end
  end

  # GET /formadepagos/1/edit
  def edit
    @formadepago = Formadepago.find(params[:id])
  end

  # POST /formadepagos
  # POST /formadepagos.json
  def create
    @formadepago = Formadepago.new(params[:formadepago])

    respond_to do |format|
      if @formadepago.save
        format.html { redirect_to @formadepago, :notice => 'Formadepago was successfully created.' }
        #format.json { render json: @formadepago, status: :created, location: @formadepago }
      else
        format.html { render :action => "new" }
        #format.json { render json: @formadepago.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /formadepagos/1
  # PUT /formadepagos/1.json
  def update
    @formadepago = Formadepago.find(params[:id])

    respond_to do |format|
      if @formadepago.update_attributes(params[:formadepago])
        format.html { redirect_to @formadepago, :notice => 'Formadepago was successfully updated.' }
        #format.json { head :ok }
      else
        format.html { render :action => "edit" }
        #format.json { render json: @formadepago.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /formadepagos/1
  # DELETE /formadepagos/1.json
  def destroy
    @formadepago = Formadepago.find(params[:id])
    @formadepago.destroy

    respond_to do |format|
      format.html { redirect_to formadepagos_url }
      #format.json { head :ok }
    end
  end
end

class RenglonReciboDocsController < ApplicationController
  # GET /renglon_recibo_docs
  # GET /renglon_recibo_docs.json
  def index
    @recibo = Recibo.find(params[:recibo_id])
    @renglon_recibo_docs = @recibo.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @renglon_recibo_docs }
    end
  end

  # GET /renglon_recibo_docs/1
  # GET /renglon_recibo_docs/1.json
  def show
    @recibo = Recibo.find(params[:recibo_id])
    @renglon_recibo_doc = @recibo.renglon_recibo_docs.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @renglon_recibo_doc }
    end
  end

  # GET /renglon_recibo_docs/new
  # GET /renglon_recibo_docs/new.json
  def new
    @renglon_recibo_doc = RenglonReciboDoc.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @renglon_recibo_doc }
    end
  end

  # GET /renglon_recibo_docs/1/edit
  def edit
    @recibo = Recibo.find(params[:recibo_id])
    @renglon_recibo_doc = @recibo.renglon_recibo_docs.find(params[:id])
    respond_to do |format|
      format.html { render :layout => 'special_form'}# new.html.erb
      format.json { render json: @renglon_recibo_doc }
    end
  end

  # POST /renglon_recibo_docs
  # POST /renglon_recibo_docs.json
  def create
    @recibo = Recibo.find(params[:recibo_id])
    @renglon_recibo_doc = @recibo.renglon_recibo_docs.build(params[:renglon_recibo_doc])

    respond_to do |format|
      if @renglon_recibo_doc.save
        #format.html { redirect_to @recibo, notice: 'Renglon recibo was successfully created.' }
        format.json { render json: @renglon_recibo_doc }
      else
        #format.html { render action: "new" }
        format.json { render json: @renglon_recibo_doc.errors }
      end
    end
  end

  # PUT /renglon_recibo_docs/1
  # PUT /renglon_recibo_docs/1.json
  def update
    @recibo = Recibo.find(params[:recibo_id])
    @renglon_recibo_doc = @recibo.renglon_recibo_docs.find(params[:id])

    respond_to do |format|
      if @renglon_recibo_doc.update_attributes(params[:renglon_recibo_doc])
        #format.html { redirect_to @recibo, notice: 'Renglon recibo was successfully updated.' }
        format.json { render json: @renglon_recibo_doc }
      else
        #format.html { render action: "edit" }
        format.json { render json: @renglon_recibo_doc.errors }
      end
    end
  end

  # DELETE /renglon_recibo_docs/1
  # DELETE /renglon_recibo_docs/1.json
  def destroy
    @recibo = Recibo.find(params[:recibo_id])
    respond_to do |format|
      if @renglon_recibo = @recibo.renglon_recibo_docs.find(params[:id]).destroy
        format.html { head :ok }
        format.json { head :ok }
      else
        format.html { head :ok }
        format.json { head :ok }
      end
    end
  end
end

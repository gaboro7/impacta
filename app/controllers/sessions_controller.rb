class SessionsController < ApplicationController

  def new

    if (session[:return_to] != nil)
      cookies[:last_url] = session[:return_to]
      if session[:return_to] == "/"
        respond_to do |format|
          format.html  { render :layout => "_signin"}# index.html.erb
          #format.json { render json: @impuestos }
        end
      end
    else
      respond_to do |format|
        format.html  { render :layout => false}# index.html.erb
        #format.json { render json: @impuestos }
      end
    end
  end

  def create
    user = User.authenticate(params[:session][:nombre], params[:session][:password])
    if user.nil?
      flash.now[:error] = "La combinacion Nombre/Password no es valida."
      render 'new'
    else
      sign_in user
      redirect_back_or cookies[:last_url]
    end

  end


  def destroy
    sign_out
    redirect_to root_path
  end
end


class PageController < ApplicationController

before_filter :authenticate

  def home
    respond_to do |format|
     format.html { render :layout => false}
    end
  end

end

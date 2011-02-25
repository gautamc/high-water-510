class PlacesController < ApplicationController
  before_filter :authenticate_user!

  def index
  end
  
  def create
    @place = Place.new(params[:place])
    respond_to do |format|
      if @place.save
        @places = Place.all
        format.html { render :partial => 'index' }
        format.js
      else
        format.html { render :partial => 'new' }
        format.js
      end
    end
  end
  
  def update
  end
  
end


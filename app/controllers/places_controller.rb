class PlacesController < ApplicationController
  before_filter :authenticate_user!
  
  autocomplete :place, :name
  
  def index
    params[:page] ||= 1
    @places = Place.paginate(:page => params[:page], :per_page => 10)
    respond_to do |format|
      format.js
    end
  end
  
  def create
    @place = Place.new(params[:place])
    respond_to do |format|
      if @place.save
        last_page = Place.count%10 == 0 ? Place.count/10 : (Place.count/10)+1
        @places = Place.paginate(:page => last_page, :per_page => 10)
        format.html { render :partial => 'index' }
        format.js
      else
        format.html { render :partial => 'new' }
        format.js
      end
    end
  end
  
end

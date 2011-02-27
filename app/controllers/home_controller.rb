class HomeController < ApplicationController
  
  def index
    
    if user_signed_in?
      @site = Site.where(:user_id => current_user.id).first
      @user = current_user
      
      @place = Place.new
      @places = Place.paginate(:page => 1, :per_page => 10)
      
      @offer = Offer.new
      @offers = Offer.where(:site_id => current_user.site.id).paginate(:page => 1, :per_page => 10)

      render :template => '/home/user_index'
    else
      @sites = Site.all
    end
    
  end
  
end

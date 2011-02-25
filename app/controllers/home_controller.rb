class HomeController < ApplicationController
  
  def index
    
    if user_signed_in?
      @site = Site.where(:user_id => current_user.id).first
      @user = current_user
      
      @place = Place.new
      @places = Place.all
      
      @offer = Offer.new
      @offers = Offer.where(:site_id => current_user.site.id)

      render :template => '/home/user_index'
    else
      @offers = Offer.all
    end
    
  end
  
end

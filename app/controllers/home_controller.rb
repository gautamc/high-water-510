class HomeController < ApplicationController
  
  def index
    
    if user_signed_in?
      render :template => '/home/user_index'
    end
    
  end
  
end

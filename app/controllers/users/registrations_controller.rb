class Users::RegistrationsController < Devise::RegistrationsController
  skip_before_filter :require_no_authentication, :only => [:new, :create]

  def new
    @user = User.new
    @user.site = Site.new
  end

  def update
    @user = current_user
    @user.attributes = params[:user]
    respond_to do |format|
      if @user.save
        format.html { render :partial => 'edit' }
        format.js
      else
        format.html { render :partial => 'edit' }
        format.js
      end
    end
  end
  
end

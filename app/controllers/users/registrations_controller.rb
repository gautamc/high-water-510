class Users::RegistrationsController < Devise::RegistrationsController
  skip_before_filter :require_no_authentication, :only => [:new, :create]

  def new
    @user = User.new
    @user.site = Site.new
  end

  def update
    @user = current_user
    if params[:user][:password].blank? && params[:user][:password_confirmation].blank?
      params[:user][:password] = params[:user][:password_confirmation] = nil
    end
    @user.attributes = params[:user]
    respond_to do |format|
      if @user.save
        sign_in User, @user, :bypass => true
        format.html { render :partial => 'edit' }
        format.js
      else
        format.html { render :partial => 'edit' }
        format.js
      end
    end
  end
  
end

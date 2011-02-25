class Users::RegistrationsController < Devise::RegistrationsController
  skip_before_filter :require_no_authentication

  def new
    @user = User.new
    @user.site = Site.new
  end
  
end

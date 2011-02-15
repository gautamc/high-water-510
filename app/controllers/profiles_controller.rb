class ProfilesController < ApplicationController
  respond_to :html, :xml
  
  before_filter :authenticate_user!

  def index
    @users = User.find(:all)
    respond_with(@users) do |format|  
      format.xml { render :xml => @users.map { |u| u.profile }.to_xml }  
    end  
  end
  
  def show
    @profile = current_user.profile
  end
  
  def edit
    @profile = Profile.find(params[:id])
  rescue Mongoid::Errors::DocumentNotFound
    redirect_to(root_path)
  end

  def update
    @profile = Profile.find(params[:id])
    @profile.attributes = params[:profile]
    @profile.address.attributes = params[:profile][:address]
    if @profile.valid? && @profile.address.valid?
      @profile.save!
      flash[:notice] = t(:profile_update_success)
      redirect_to(edit_profile_path(current_user.profile))
    else
      render :action => "edit"
    end
  end
  
end

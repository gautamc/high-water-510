class OffersController < ApplicationController
  
  before_filter :authenticate_user!
  
  # GET /offers
  # GET /offers.xml
  def index
    @offers = Offer.where(:site_id => current_user.site.id)
    
    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @offers.to_xml }
    end
  end
  
  # GET /offers/1
  # GET /offers/1.xml
  def show
    @offer = Offer.find(params[:id])
    
    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @offer }
    end
  end

  # GET /offers/new
  # GET /offers/new.xml
  def new
    @offer = Offer.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @offer }
    end
  end

  # GET /offers/1/edit
  def edit
    @offer = Offer.find(params[:id])
  end

  # POST /offers
  # POST /offers.xml
  def create
    @offer = Offer.new(params[:offer])
    @offer.site = current_user.site

    respond_to do |format|
      if @offer.save
        @offers = Offer.where(:site_id => current_user.site.id)
        format.html { redirect_to(@offer, :notice => t(:create_success)) }
        format.xml  { render :xml => @offer, :status => :created, :location => @offer }
        format.js
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @offer.errors, :status => :unprocessable_entity }
        format.js
      end
    end
  end

  # PUT /offers/1
  # PUT /offers/1.xml
  def update
    @offer = Offer.find(params[:id])

    respond_to do |format|
      if @offer.update_attributes(params[:offer])
        @offers = Offer.where(:site_id => current_user.site.id)
        @offer = Offer.new
        format.html { redirect_to(@offer, :notice => t(:update_success)) }
        format.xml  { head :ok }
        format.js
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @offer.errors, :status => :unprocessable_entity }
        format.js
      end
    end
  end

  # DELETE /offers/1
  # DELETE /offers/1.xml
  def destroy
    @offer = Offer.find(params[:id])
    @offer.destroy
    flash[:notice] = "Offer Destroyed!"
    respond_to do |format|
      format.html { redirect_to(root_url) }
      format.xml  { head :ok }
    end
  end
end

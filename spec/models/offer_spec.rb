# coding: utf-8

require File.dirname(__FILE__) + '/../spec_helper'

describe Offer do 

  before(:each) do
    @owner = User.create!(
      :email => 'user.one@test.com', :password => 'letmein', :password_confirmation => 'letmein',
      :telephone => "1234567890", :name => "User one",
      :site_attributes => {
        :name => "site one", :url => "http://siteone.com.br"
      }
    )
    @place = Place.create!(
      :name => "McDonalds",
      :address => "383 Madison Ave, New York City, 10179, USA"
    )
    
    @place_two = Place.create!(
      :name => "KFC",
      :address => "385 Madison Ave, New York City, 10178, USA"
    )
  end
  
  describe "valdations" do
  
    before(:each) do
      @offer = Offer.new
      @offer.valid?
    end

    it "should validate the offer fields" do
      @offer.errors[:title].first.should == "Não pode estar em branco"
      @offer.errors[:title][1].should == "é muito curto (mínimo de 5 caracteres)"
      @offer.errors[:original_price].first.should == "Não pode estar em branco"
      @offer.errors[:original_price][1].should == "não é um valor numérico"
      @offer.errors[:final_price].first.should == "Não pode estar em branco"
      @offer.errors[:final_price][1].should == "não é um valor numérico"
      @offer.errors[:discount_percentage].first.should == "Não pode estar em branco"
      @offer.errors[:discount_percentage][1].should == "não é um valor numérico"
      @offer.errors[:expires_at].first.should == "Não pode estar em branco"
      @offer.errors[:url].first.should == "não é válido"
    end
    
  end
  
  describe "Creation" do
    
    it "should create an offer with an existing place" do
      offer = Offer.new(
        :title => 'Test Offer #1',
        :final_price => 25, :original_price => 50, :discount_percentage => 50,
        :expires_at => Time.now + 10.days, :url => @owner.site.url.to_s + '/offers/1'
      )
      offer.site = @owner.site
      offer.place = @place
      offer.save!
      offer.persisted?.should be_true
      offer.place.address.should == @place.address
    end
    
  end
  
  describe "Updaton" do
    
    before(:each) do
      @offer = Offer.new(
        :title => 'Test Offer #1',
        :final_price => 25, :original_price => 50, :discount_percentage => 50,
        :expires_at => Time.now + 10.days, :url => @owner.site.url.to_s + '/offers/1'
      )
      @offer.site = @owner.site
      @offer.place = @place
      @offer.save!
    end
    
    it "should allow updation of an offer and associated place" do
      @offer.attributes = {
        :title => 'Test Offer #1',
        :final_price => 50, :original_price => 100, :discount_percentage => 50,
        :expires_at => Time.now + 5.days, :url => @owner.site.url.to_s + '/offers/1'
      }
      
      @offer.changed?.should be_true
      @offer.save!
      @offer.persisted?.should be_true
      
      @offer.title.should == "Test Offer #1"
      @offer.place.address.should == @place.address
      @offer.original_price.should == 100
      
      ## First remove this offer from its current palce ##
      @place.offers = @place.offers.reject {|o| o.id == @offer.id}
      @place.save!
      
      ## now, add it to the new palce ##
      @offer.place = @place_two
      @offer.save!
      @offer.persisted?.should be_true
      @offer.place.address.should == @place_two.address

      @place.offers.map(&:title).join(", ").should == ""
      @place_two.offers.map(&:title).join(", ").should == "Test Offer #1"
      
      @offer2 = Offer.new(
        :title => 'Test Offer #2',
        :final_price => 25, :original_price => 50, :discount_percentage => 50,
        :expires_at => Time.now + 10.days, :url => @owner.site.url.to_s + '/offers/2'
      )
      @offer2.place = @place
      @offer2.site = @owner.site
      @offer2.save!
    
      @place.offers.map(&:title).join(", ").should == "Test Offer #2"
      @place_two.offers.map(&:title).join(", ").should == "Test Offer #1"
    end
    
  end
  
end

# coding: utf-8

require File.dirname(__FILE__) + '/../spec_helper'

describe User do 
  
  describe "valdations" do
    
    before(:each) do
      @user = User.new
      @user.valid?
      
      valid_user = User.new(
        :email => 'user.two@test.com', :password => 'letmein', :password_confirmation => 'letmein',
        :telephone => "1234567890", :name => "User two",
        :site_attributes => {
          :name => "site two", :url => "http://sitetwo.com.br"
        }
      )
      valid_user.save!
      
      @user_two = User.new(
        :email => 'user.two@test.com', :password => 'let', :password_confirmation => '',
        :site_attributes => {
        }
      )
      @user_two.valid?
    end
    
    it "should validate the user fields and the associated site" do
      @user.errors[:email].first.should == "Não pode estar em branco"
      @user.errors[:password].first.should == "Não pode estar em branco"
      @user.errors[:name].first.should == "Não pode estar em branco"
      @user.errors[:telephone].first.should == "Não pode estar em branco"
      
      @user_two.errors[:email].first.should == "Este e-mail já está tomada"
      @user_two.errors[:password].first.should == "não coincide com a confirmação"
      @user_two.errors[:password][1].should == "é muito curto (mínimo de 6 caracteres)"
      @user_two.errors[:site].first.should == "não é válido"
      @user_two.errors[:name].first.should == "Não pode estar em branco"
      @user_two.errors[:telephone].first.should == "Não pode estar em branco"
      
      @user_two.site.errors[:url].first.should == "Não pode estar em branco"
      @user_two.site.errors[:url].first.should == "Não pode estar em branco"
      @user_two.site.errors[:url][1].should == "não possui formato válido. Deve ser assim: http://sitename ..."
    end
    
  end
  
  describe "Creation via nested attributes" do
    
    it "should create an user and the associated site" do
      user = User.new(
        :email => 'user.one@test.com', :password => 'letmein', :password_confirmation => 'letmein',
        :telephone => "1234567890", :name => "User One",
        :site_attributes => {
          :name => "site one", :url => "http://siteone.com.br"
        }
      )
      user.save!
      user.persisted?.should be_true
      user.site.persisted?.should be_true
    end
    
  end
  
  describe "Updaton via nested attributes" do
    
    before(:each) do
      @user = User.new(
        :email => 'user.one@test.com', :password => 'letmein', :password_confirmation => 'letmein',
        :telephone => "9966406665", :name => "User One",
        :site_attributes => {
          :name => "site one", :url => "http://siteone.com.br"
        }
      )
      @user.save!
    end
    
    it "should update an user and the associated site" do
      @user.attributes = {
        :email => 'user.one.updated@test.com', :password => 'letmeinnow', :password_confirmation => 'letmeinnow',
        :telephone => "9966406664", :name => "User One Updated",
        :site_attributes => {
          :name => "site one updated", :url => "http://siteoneupdated.com.br"
        }
      }
      
      site_id = @user.site.id

      @user.changed?.should be_true
      @user.site.changed?.should be_true
      @user.save!
      @user.persisted?.should be_true
      @user.site.persisted?.should be_true
      
      @user.email.should == "user.one.updated@test.com"
      @user.site.name.should == "site one updated"
      @user.site.url.should == "http://siteoneupdated.com.br"

      @user.site.id.should == site_id
    end
    
  end
  
end

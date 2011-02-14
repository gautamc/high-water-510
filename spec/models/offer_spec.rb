require File.dirname(__FILE__) + '/../spec_helper'

describe Offer do 
  it { should be_referenced_in :profile }
  
  describe "creation" do
    
    before(:each) do
      @user = User.create!(
        :email => 'test@test.com',
        :password => 'password',
        :password_confirmation => 'password'
      )
      @user.profile = Profile.new(
        :first_name => 'test',
        :last_name  => 'test',
        :dob        => Date.today - 30.years,
        :mobile_num => '9966406665',
      )
      @user.save!
    end
    
    it "should allow creation of multiple offers associated with one user" do
      1.upto(10) do |offer_count|
        offer = Offer.new(
          :product => 'product #{offer_count}',
          :price => 12.2 + offer_count,
          :offer_date => Date.today + offer_count.days
        )
        @user.profile.offers << offer
      end
      @user.profile.offers.count.should == 10
    end
    
  end
  
end

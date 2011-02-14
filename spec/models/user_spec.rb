require File.dirname(__FILE__) + '/../spec_helper'

describe User do 
  it { should embed_one :profile }
  it { should validate_uniqueness_of :email }

  describe "Creation" do
    
    it "should create an associated profile" do
      user_one = User.new(
        "email" => 'user.one@test.com', "password" => 'letmein', "password_confirmation" => 'letmein',
        "profile" => {
          "first_name" => "gautam", "last_name" => "chekuri",
          "mobile_num" => "9966406665"
        }
      )
      #, "address" => {
      #      :address_line1 => "e-40", :address_line2 => "afochs", :city => "secunderabad",
      #      :zip => "500094", :state => "AP", :country => "India"
      #    }
      user_one.should be_valid
      user_one.save!
      puts user_one.inspect
    end
    
  end

  describe "Updation" do

    before(:each) do
      @user = User.new(
        :email => '',
        :password => '', :password_confirmation => ''
      )
    end
    
    it "should " do
      profile = {
        :first_name => "gautam", :last_name => "chekuri",
        "dob(1i)" => "1980", "dob(2i)" => "3", "dob(3i)" => "7",
        :mobile_num => "9966406665", :address =>{
          :address_line1 => "e-40", :address_line2 => "afochs", :city => "secunderabad",
          :zip => "500094", :state => "AP", :country => "India"
        }
      }
    end
    
  end
  
end

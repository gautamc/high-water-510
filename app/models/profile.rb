class Profile
  
  include Mongoid::Document
  
  field :first_name
  field :last_name
  field :dob, :type => Date
  field :mobile_num
  
  validates_presence_of :first_name, :last_name, :mobile_num, :unless => lambda {|r| r.skip_validations}
  validates_length_of  :first_name, :last_name, :minimum => 2, :unless => lambda {|r| r.skip_validations}
  attr_accessible(
    :first_name, :last_name, :mobile_num, :dob
    #, :address_attributes
  )
  
  #attr_accessor :address_attributes
  
  embeds_one :address
  embedded_in :profile, :inverse_of => :profile
 
  #accepts_nested_attributes_for :address
  
  attr_accessor :skip_validations

  #def address_attributes=(params)
  #  if address
  #    address.attributes = params
  #  else
  #    address = Address.new(params)
  #  end
  #end
end

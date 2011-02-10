class Address
  
  include Mongoid::Document
  
  field :address_line1
  field :address_line2
  field :city
  field :zip
  field :state
  field :country
  
  validates_presence_of :address_line1, :city, :state, :zip, :unless => lambda {|r| r.skip_validations}
  attr_accessible(:address_line1, :address_line2, :city, :zip, :state, :country)
  
  embedded_in :profile, :inverse_of => :address
  
  attr_accessor :skip_validations
  
end

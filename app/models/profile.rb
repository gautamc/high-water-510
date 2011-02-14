class Profile
  
  include Mongoid::Document
  
  field :first_name
  field :last_name
  field :dob, :type => Date
  field :mobile_num
  
  #field :avatar_uid
  #image_accessor :avatar
  
  validates_presence_of :first_name, :last_name, :mobile_num, :unless => lambda {|r| r.skip_validations}
  validates_length_of  :first_name, :last_name, :minimum => 2, :unless => lambda {|r| r.skip_validations}
  attr_accessible(
    :first_name, :last_name, :mobile_num, :dob
  )
  
  embeds_one :address
  embedded_in :user, :inverse_of => :profile

  references_many :offers
  
  attr_accessor :skip_validations, :remove_avatar
  
end

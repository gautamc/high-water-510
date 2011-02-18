class Place
  
  include Mongoid::Document
  
  field :name
  field :address
  field :lat
  field :lng
  
  validates_presence_of :name, :address

  references_many :offers
  
end

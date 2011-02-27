class Place
  
  include Mongoid::Document
  
  field :name
  field :address
  field :lat
  field :lng
  
  validates_presence_of :name, :address
  validates_uniqueness_of :name

  references_many :offers
  
end

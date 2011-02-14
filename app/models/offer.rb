class Offer
  
  include Mongoid::Document
  
  field :title
  field :original_price
  field :final_price
  field :expires_at, :type => DateTime
  field :url
  
  validates_numericality_of :original_price
  validates_numericality_of :final_price
  
  referenced_in :profile
  
end

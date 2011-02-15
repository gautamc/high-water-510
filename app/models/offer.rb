class Offer
  
  include Mongoid::Document
  
  field :title
  field :original_price
  field :final_price
  field :expires_at, :type => DateTime
  field :url
  
  validates_presence_of :title, :original_price
  validates_length_of :title, :minimum => 5
  validates_numericality_of :original_price
  validates_numericality_of :final_price
  validates_format_of :url, :with => /^(http|https):\/\/.*/
  
  referenced_in :profile
  
end

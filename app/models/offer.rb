class Offer
  
  include Mongoid::Document
  
  field :title
  field :final_price
  field :original_price
  field :discount_percentage
  field :expires_at, :type => DateTime
  field :url
  
  validates_presence_of :title, :original_price, :final_price, :discount_percentage, :expires_at
  validates_length_of :title, :minimum => 5
  validates_numericality_of :original_price
  validates_numericality_of :final_price
  validates_numericality_of :discount_percentage
  validates_format_of :url, :with => /^(http|https):\/\/.*/
  
  referenced_in :site
  referenced_in :place
  
end

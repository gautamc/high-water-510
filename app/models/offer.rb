class Offer
  
  include Mongoid::Document
  
  field :title
  field :final_price
  field :original_price
  field :discount_percentage
  field :expires_at, :type => DateTime
  field :url
  
  belongs_in :site
  belongs_in :place
  
  validates_presence_of :title, :original_price, :final_price, :discount_percentage, :expires_at, :place
  validates_length_of :title, :minimum => 5
  validates_numericality_of :original_price
  validates_numericality_of :final_price
  validates_numericality_of :discount_percentage
  validates_format_of :url, :with => /^(http|https):\/\/.*/, :allow_nil => true, :allow_blank => true
  
  attr_accessible :title, :final_price, :original_price, :discount_percentage, :expires_at, :url, :place_attributes
  
  after_save lambda {
    |record|
    record.place.save! if !record.place.persisted? || record.place.changed?
  }
  
  def place_attributes=(params)
    self.place = Place.where(:name => params[:name]).first
  end
  
end

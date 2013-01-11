class Site
  
  include Mongoid::Document
  
  field :name
  field :url
  
  belongs_in :user
  has_many :offers
  
  #validates_presence_of :url
  #validates_format_of :url, :with => /^(http|https):\/\/.*/
  
end

class Site
  
  include Mongoid::Document
  
  field :name
  field :url
  
  referenced_in :user
  references_many :offers
  
  #validates_presence_of :url
  #validates_format_of :url, :with => /^(http|https):\/\/.*/
  
end

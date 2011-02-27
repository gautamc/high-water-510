class User
  
  include Mongoid::Document
  
  # Does not help in making the nested attribute work, hence
  # implemented nested_attributes as a part of this model
  #include Mongoid::NestedAttributes
  
  # Include default devise modules. Others available are:
  # :token_authenticatable, :encryptable, :confirmable, :lockable, :timeoutable and :omniauthable
  devise(
    :database_authenticatable, :registerable,
    :recoverable, :rememberable, :trackable, :validatable
  )
  
  field :name
  field :telephone
  field :xml_feed_url

  references_one :site
  accepts_nested_attributes_for :site
  
  validates_presence_of :name, :telephone
  validates_format_of(
    :xml_feed_url,
    :with => /^(http|https):\/\/.*/,
    :allow_nil => true,
    :allow_blank => true
  )
  validates_associated :site
  
  attr_accessible :email, :password, :password_confirmation, :name, :telephone, :site_attributes, :xml_feed_url
  
  after_save lambda {
    |record|
    record.site.save! if !record.site.persisted? || record.site.changed?
  }
  
  def site_attributes=(params)
    self.site ||= Site.new
    self.site.attributes = params
  end
  
end

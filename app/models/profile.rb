class Profile
  
  include Mongoid::Document
  
  field :first_name
  field :last_name
  field :dob, :type => Date
  field :mobile_num
  field :site_url
  field :sitemap
  field :offers_xml_url
  field :slug
  
  #field :avatar_uid
  #image_accessor :avatar
  
  validates_presence_of :first_name, :last_name, :mobile_num, :unless => lambda {|r| r.skip_validations}
  validates_length_of  :first_name, :last_name, :minimum => 2, :unless => lambda {|r| r.skip_validations}
  
  validates_format_of :site_url, :with => /^(http|https):\/\/.*/, :allow_nil => true
  validates_format_of :sitemap, :with => /^(http|https):\/\/.*/, :allow_nil => true
  validates_format_of :offers_xml_url, :with => /^(http|https):\/\/.*/, :allow_nil => true

  attr_accessible(
    :first_name, :last_name, :mobile_num, :dob, :site_url, :sitemap, :offers_xml_url
  )
  
  referenced_in :user, :inverse_of => :profile  
  references_many :offers
  embeds_one :address
  
  attr_accessor :skip_validations, :remove_avatar

  #before_save :set_slug

  def set_slug(slug = nil)
    title = "#{self.first_name}-#{self.last_name}".strip
    if (title and self.slug.blank?) || slug
      slug ||= title
      slug = slug.to_permalink.strip
      slug_index = nil
      # get all slugs of the profiles
      # -- VERY INEFFICIENT - fix this
      slugs = Profile.all.collect(&:slug)
      while slugs.include?([slug, slug_index].compact.join('-'))
        slug_index ||= 0
        slug_index += 1
      end
      self.slug = [slug, slug_index].compact.join('-')
    end
  end
  
end

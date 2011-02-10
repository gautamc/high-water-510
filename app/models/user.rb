class User
  
  include Mongoid::Document
  
  # Include default devise modules. Others available are:
  # :token_authenticatable, :encryptable, :confirmable, :lockable, :timeoutable and :omniauthable
  devise(
    :database_authenticatable, :registerable,
    :recoverable, :rememberable, :trackable, :validatable
  )
  
  validates_uniqueness_of :email, :case_sensitive => false
  attr_accessible :email, :password, :password_confirmation

  embeds_one :profile
  
  before_create :generate_profile

  protected
  def generate_profile
    profile = Profile.new
    profile.skip_validations = true
    address = Address.new
    profile.skip_validations = true
    profile.address = address
    self.profile = profile
  end
  
end

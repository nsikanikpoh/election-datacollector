class User < ApplicationRecord
  mount_uploader :image, ImageUploader
  before_validation :ensure_token
  before_validation :affiliate_link
  has_many :posts, dependent: :destroy
  
  def ensure_token
    self.token = generate_hex(:token) unless token.present?
  end

  def generate_hex(column)
    loop do
      hex = SecureRandom.hex
      break hex unless self.class.where(column => hex).any?
    end
  end

  def affiliate_link
    if self.is_a?(FundRaiser)
        self.url = "https://milmap.herokuapp.com/prospects/new/?referrer_code=#{self.affiliate_code}"
    elsif self.is_a?(Member)
         self.url = "https://milmap.herokuapp.com/members/new/?referrer_code=#{self.affiliate_code}"
     end
  end
  # Include default devise modules. Others available are:
   # :lockable, :timeoutable and :omniauthable

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :omniauthable, omniauth_providers: [:facebook, :linkedin, :google_oauth2, :twitter]

  def self.create_from_provider_data(provider_data)
    where(provider: provider_data.provider, uid: provider_data.uid).first_or_create do | user |
      user.email = provider_data.info.email
      user.password = Devise.friendly_token[0, 20]
      user.name = provider_data.info.name
      #user.last_name = provider_data.info.last_name
      user.image = provider_data.info.image.gsub('http://','https://')
      
      #user.gender = provider_data.info.gender
      # user.gender = provider_data.info.birthday
     #user.phone  = provider_data.info.phone
      
      #user.address = provider_data.info.hometown
      
      user.location = provider_data.info.location
      #user.state = provider_data.info.state
    
    end
  end

     def ambassador?
      self.is_a?(Ambassador) 
    end


    def member?
    	self.is_a?(Member) 
    end


    def patriot?
    	self.is_a?(Patriot) 
    end

    def admin?
      self.is_a?(Admin) 
    end 

    def champion?
      self.is_a?(Champion) 
    end  

    def fund_raiser?
      self.is_a?(FundRaiser) 
    end

    def prospect?
      self.is_a?(Prospect) 
    end     

  has_many :affiliations, :foreign_key => "affiliate_id", :dependent => :destroy
  has_many :referrals, :through => :affiliations, :source => :referred


 
  # map.affiliate_referral 'a/:referrer_code', :controller => 'referrals', :action => 'new'
  
  

end

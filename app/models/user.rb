class User < ApplicationRecord
  mount_uploader :image, ImageUploader
  before_validation :ensure_token
  
  def ensure_token
    self.token = generate_hex(:token) unless token.present?
  end

  def generate_hex(column)
    loop do
      hex = SecureRandom.hex
      break hex unless self.class.where(column => hex).any?
    end
  end

  # Include default devise modules. Others available are:
   # :lockable, :timeoutable and :omniauthable

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :omniauthable, omniauth_providers: [:facebook, :linkedin, :google_oauth2, :twitter]


  has_many :reports
  
   def admin?
      self.is_a?(Admin) 
    end 

 
end

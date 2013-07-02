class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable, :lockable and :timeoutable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :confirmable, :token_authenticatable,
         :oauthable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me, :username, :has_username, :is_admin, :profile
  
  validates :username, :presence => true
  validates_uniqueness_of :username
  
  cattr_reader :per_page
  @@per_page = 20
  
  has_one :profile
  
  after_create :create_profile
  
  def self.find_for_facebook_oauth(access_token, signed_in_resource=nil)
    data = ActiveSupport::JSON.decode(access_token.get('https://graph.facebook.com/me?'))

    if user = User.find_by_email(data["email"])
      user
    else
      # Create an user with a stub password.
      u = User.create!(:email => data["email"], :password => Devise.friendly_token, :username => Devise.friendly_token, :has_username => false)
      u.skip_confirmation!
      u
    end
  end
  
  def self.find_for_authentication(conditions={})
    if conditions[:login] =~ /^([\w\.%\+\-]+)@([\w\-]+\.)+([\w]{2,})$/i # email regex
      conditions[:email] = conditions[:login]
      conditions.delete("login")
    end
    super
  end
  
  def to_s
    self.username
  end
  
  def create_profile
    build_profile
  end
end

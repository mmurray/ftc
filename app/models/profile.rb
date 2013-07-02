class Profile < ActiveRecord::Base
  belongs_to :user
  
  attr_accessible :avatar, :user
  
  # Paperclip
  has_attached_file :avatar,
    :storage => :s3,
    :s3_credentials => "#{RAILS_ROOT}/config/s3.yml",
    :bucket => 'ftc-static',
    :path=>"/avatars/:style/:id/:filename",
    :styles => {
      :thumb => "45x45#",
      :small => "100x100#",
      :tiny => "20x20#"
    }
  
  def cdn_url(variant = nil)
    avatar.url(variant).gsub("http://s3.amazonaws.com/ftc-static","http://cdn.fantasytradecritic.com")
  end
  
end

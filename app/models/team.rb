class Team < ActiveRecord::Base
  belongs_to :league
  has_many :players, :dependent => :destroy
  
  cattr_reader :per_page
  @@per_page = 20
  
  def to_s
    name
  end
end

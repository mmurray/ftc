class League < ActiveRecord::Base
  validates :name, :presence => true
  validates :sport, :presence => true
  validates :abbreviation, :presence => true
  
  has_many :team
  has_many :player
  
  def to_s
    name
  end
end

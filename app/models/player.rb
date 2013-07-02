class Player < ActiveRecord::Base
  belongs_to :team
  belongs_to :league
  
  cattr_reader :per_page
  @@per_page = 20
  
  def to_s
    name
  end
  
  def name_for_autocomplete
    self.name + '_'+self.team.abbreviation
  end
  
  def url
    "/players/"+self.id.to_s+"/"+self.name.parameterize+"-"+self.league.abbreviation.downcase
  end
  
end

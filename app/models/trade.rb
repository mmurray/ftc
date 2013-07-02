class Trade < ActiveRecord::Base
  belongs_to :league
  belongs_to :user
  acts_as_commentable
  has_and_belongs_to_many :my_players, 
    :class_name =>"Player", 
    :join_table => "my_players",
    :foreign_key => "trade_id",
    :association_foreign_key => "player_id"
  has_and_belongs_to_many :their_players, 
    :class_name =>"Player", 
    :join_table => "their_players",
    :foreign_key => "trade_id",
    :association_foreign_key => "player_id" 
  
  validates_presence_of :user, :league
  
  cattr_reader :per_page
  @@per_page = 9
  
  def author
    user
  end
  
  def vote_for
    
    if (for_votes == nil)
      self.for_votes = 1
    else
      self.for_votes += 1 
    end
    
    if (total_votes == nil)
      self.total_votes = 1
    else
      self.total_votes += 1
    end
    
    analyze_votes
  end
  
  def vote_against
    
    if (against_votes == nil)
      self.against_votes = 1
    else
      self.against_votes += 1 
    end
    
    if (total_votes == nil)
      self.total_votes = 1
    else
      self.total_votes += 1
    end
    
    analyze_votes
  end
  
  def analyze_votes
    total = total_votes
    if(for_votes > against_votes)
      self.percent = ((for_votes.to_f / total.to_f) * 100).floor
      self.do_it = true
    elsif (against_votes > for_votes)
      self.percent = ((against_votes.to_f / total.to_f) * 100).floor
      self.do_it = false
    else
      self.percent = 50
      self.do_it = true
    end
    
  end
  

end
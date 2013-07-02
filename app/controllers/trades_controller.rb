class TradesController < ApplicationController
  
  before_filter :authenticate_user!, :only => [:new,:create]
  respond_to :html, :xml, :json
  
  # GET /trades
  # GET /trades.xml
  def index
    
    @nav = 'browse'
    @leagues = League.all
    
    params[:sort] = 'recent' if params[:sort] == nil
    params[:league] = 'all' if params[:league] == nil
    
    @sort = params[:sort].capitalize
    @league = params[:league].capitalize
    
    if(params[:sort] == 'popular')
      order = 'total_votes desc'
    else
      order = 'created_at desc'
    end
    
    if(params[:league] == 'all')
      @trades = Trade.paginate(:page=>params[:page],
                                :order=>order)
    elsif(params[:league] == 'mine')
      @trades = Trade.paginate(:page=>params[:page],
                                  :order=>order,
                                  :conditions=>['user_id=?',current_user.id])
      @mine = 'My '
    else
      order = 'trades.'+order
      @trades = Trade.paginate(:page=>params[:page],
                                :include=>:league,
                                :order=>order,
                                :conditions=> ['leagues.abbreviation=?',params[:league].upcase])
    end
    
    respond_with @trades
  end
  
  # GET /trades
  # GET /trades.xml
  def search
    # @trades = Trade.paginate(:page=>params[:page],
    #                           :include=>:my_players,
    #                           :conditions=>['players.name in (?)', "%#{search}%"])
    
    #@trades = Trade.paginate(:page=>params[:page], :include=>:my_players,:conditions=>['players.name in (?)', '%#{search}%'])
    @nav = 'search'
    @leagues = League.all
    
    params[:search_by] = '' if params[:search_by] == nil
    params[:search] = '' if params[:search] == nil
    
    @search_by = params[:search_by]
    @search = params[:search]
    
    @players = []
    @teams = []
    @users = []
    
    if (params[:search_by] == 'players')
      @players = Player.paginate(:page=>params[:page], :conditions=>['name like (?)','%'+params[:search]+'%'] )
    elsif (params[:search_by] == 'teams')
      @teams = Team.paginate(:page=>params[:page], :conditions=>['name like (?)','%'+params[:search]+'%'])
    elsif (params[:search_by] == 'users')
      @users = User.paginate(:page=>params[:page], :conditions=>['username like (?)','%'+params[:search]+'%'])
    end
    
    respond_with @players, @teams, @users
  end 

  # GET /trades/1
  # GET /trades/1.xml
  def show
    @trade = Trade.find(params[:id])
    
    @comment = Comment.new
    
    @comments = []
    
    if(!@trade.comment.blank?)
      tradeComment = Comment.new
      tradeComment.comment = @trade.comment
      tradeComment.user = @trade.user
      tradeComment.live = true
      tradeComment.created_at = @trade.created_at
      @comments.push(tradeComment)
    end
    
    @trade.comments.live.each do |c|
      @comments.push(c)
    end

    respond_with @trade
  end

  # GET /trades/new
  # GET /trades/new.xml
  def new
    params[:league] ||= ''
    
    leagueCacheKey = "league-"+params[:league]
    @league = Rails.cache.read(leagueCacheKey)
    if(@league.nil?)
      @league = League.find_by_abbreviation(params[:league].upcase)
      if(!@league.nil?)
        Rails.cache.write(leagueCacheKey,@league)
      end
    end
    if(@league.nil?)
      redirect_to(league_select_path) and return
    end
    
    playerCacheKey = "allPlayers-"+@league.abbreviation
    @players = Rails.cache.read(playerCacheKey)
    if(@players.nil?)
      @players = Player.find_all_by_league_id(@league.id, :order=>'name ASC')
      if(!@players.nil?)
        Rails.cache.write(playerCacheKey,@players)
      end
    end
    
    
    @trade = Trade.new
    
    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @trade }
    end
  end
  
  # GET /trades/new
  # GET /trades/new.xml
  def select_league
    @trade = Trade.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @trade }
    end
  end

  # GET /trades/1/edit
  def edit
    @trade = Trade.find(params[:id])
  end

  # POST /trades
  # POST /trades.xml
  def create
    
    @trade = Trade.new(params[:trade])

    respond_to do |format|
      if @trade.save
        format.html { redirect_to(@trade, :notice => 'Trade was successfully created.') }
        format.xml  { render :xml => @trade, :status => :created, :location => @trade }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @trade.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /trades/1
  # PUT /trades/1.xml
  def update
    @trade = Trade.find(params[:id])

    if params[:do_it] == 'true'
      @trade.vote_for
    elsif params[:do_it] == 'false'
      @trade.vote_against
    end
    
    @trade.save
    set_vote_cookie(params[:id],params[:do_it])
    
    respond_with(@trade)
  end

  # DELETE /trades/1
  # DELETE /trades/1.xml
  def destroy
    @trade = Trade.find(params[:id])
    @trade.destroy

    respond_to do |format|
      format.html { redirect_to(trades_url) }
      format.xml  { head :ok }
    end
  end
end

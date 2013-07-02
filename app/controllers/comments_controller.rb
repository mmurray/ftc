class CommentsController < ApplicationController

  before_filter :load_trade
  respond_to :json, :xml, :html
  
  # GET /comments/new
  # GET /comments/new.xml
  def index
    @comment = Comment.new

    respond_with @comment
  end
  
  # GET /comments/1
  # GET /comments/1.xml
  def show
    @comment = Comment.new
    #@comment.trade = @trade

    respond_with @comment
  end
  
  def create
    @comment = @trade.comments.build(params[:comment])
    @comment.user = current_user
    @comments = @trade.comments
    if @comment.save
      flash[:notice] = "Comment successfully posted"
      @comment.live = true
      @comment.save
    end
    respond_with(@trade,@comment)
  end

  # DELETE /comments/1
  # DELETE /comments/1.xml
  def destroy
    @comment = Comment.find(params[:id])
    @comment.destroy

    respond_to do |format|
      format.html { redirect_to(comments_url) }
      format.xml  { head :ok }
    end
  end
  
  def load_trade
    @trade = Trade.find(params[:trade_id])
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
  end
end

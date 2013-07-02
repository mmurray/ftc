/** ftc 'trades' javascript
 * copyright (c) 2009 fantasytradecritic.com
 * @author mike murray
 * @website http://murz.net
 */

$(document).ready(function(){
	$.each($('.tradeBox'),function(i,ele){
		new TradeBox(ele);
	});
});

function TradeBox(element) {
	this.element;
	this.tradeId;
	this.init(element);
	return this;
};

TradeBox.prototype = {
	init: function(element){
		this.element = element;
		this.id = element.id.replace('tradeBox-','');
		this.$results = $('.tradeBox-results',element);
		this.$buttons = $('.tradeBox-buttons',element);
		this.$loading = $("<p class='loading'>Sending your vote...</p>");
		this.attachEvents();
		return this;
	},
	attachEvents: function(){
		var _self = this;
		$(this.element).delegate('.tradeBox-voteButton-yes','click',function(e){
		  e.preventDefault();
      _self.doVote('true');
		});
		$(this.element).delegate('.tradeBox-voteButton-no','click',function(e){
		  e.preventDefault();
		  _self.doVote('false');
		});


	},
	doVote: function(vote){
	  
		this.$buttons.replaceWith(this.$loading);
		var _self = this;
		
		$.ajax({
		  type:'post',
		  url:'/trades/vote/'+this.id+'.json',
		  data:{"do_it":vote},
		  success:function(data){
		    _self.handleVoteResponse.call(_self,data,vote);
		  }
		});
		
	},
	handleVoteResponse: function(data,vote){
	  var $text = $('span',this.$results);
	  var $icon = $('.tradeBox-icon',this.$results);
    $text.fadeOut();
    var label = data.trade.do_it ? "I'd do it!" : "Forget it";
    $text.html(data.trade.percent +'% say "'+label+'"');
    $text.fadeIn();
    if(data.trade.do_it){
      $icon.removeClass('down').addClass('up');
    }else{
      $icon.removeClass('up').addClass('down');
    }
    var answerDiv = document.createElement("div");
    $(answerDiv).attr('class','tradeBox-vote-answer tradeBox-vote-answer-'+vote).html("<span class='ico'></span><span class='label'>You said \""+label+"\"</span>");
    this.$loading.replaceWith(answerDiv);
	}
};
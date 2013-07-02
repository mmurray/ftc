/** ftc 'trades' javascript
 * copyright (c) 2009 fantasytradecritic.com
 * @author mike murray
 * @website http://murz.net
 */

$(document).ready(function(){
	new CreateTradeForm();
});

function CreateTradeForm() {
	this.myPlayerCount;
	this.theirPlayerCount;
	this.init();
	return this;
};

CreateTradeForm.prototype = {
	init : function(){
		this.myPlayerCount = 1;
		this.theirPlayerCount = 1;
		this.attachEvents();
		return this;
	},
	attachEvents : function(){
		var _self = this;
		
		$('.createTrade-form-field-comment textarea').textlimit('#createTrade-form_comment-count-num',1000);
		
		// $('.createTrade-form_field input').autocomplete('/players/findByName',{
		// 	maxItemsToShow:10,
		// 	autoFill:true,
		// 	delay:100,
		// 	extraParams:{league:$('.createTrade-form-field-league select').val()}
		// });

    var defaultValue = 'Enter player name...';

    $('.createTrade-form_field select').removeAttr('disabled');
    $('.createTrade-form_field select').ufd({
      skin:'sexy'
    });
    
    var $input = $('.createTrade-form_field input');
    $input.val(defaultValue);
    $input.css({color:'#999'})
    $input.focus(function(){
      $(this).css({color:'#000'});
      if($(this).val() == defaultValue){
        $(this).val('');
      }
    })

		$('.createTrade-form_player-remove').live('click',function(e){
			e.preventDefault();
			_self.removePlayer(this);
		});
		$('.createTrade-form_team-wrap .blueButton').click(function(e){
			var formDiv = ftc.util.getEnclosingClass(this,'createTrade-form_team');
			var ul = $('ul',formDiv).get(0);
			_self.addPlayer(ul);
		});
		
		// $('.createTrade-form_buttons .greenButton').click(function(e){
		// 	e.preventDefault();
		// 	$(this).html("Saving, please wait...");
		// 	$(this.parentNode).css({width:'210px'});
		// 	ftc.util.getEnclosingElement(this,'form').submit();
		// });
		
	},
	removePlayer: function(node){
		var teamEle = ftc.util.getEnclosingClass(node,'createTrade-form_team');
		if($(teamEle).hasClass('createTrade-form_team-myTeam')){
			if(this.myPlayerCount == 1){
				ftc.util.alert("Oops!","You must have at least one player per side.");
				return;
			}
			this.myPlayerCount--;
		}else if($(teamEle).hasClass('createTrade-form_team-theirTeam')){
			if(this.theirPlayerCount == 1){
				ftc.util.alert("Oops!","You must have at least one player per side.");
				return;
			}
			this.theirPlayerCount--;	
		}
		ftc.util.removeEnclosingElement(node, "li");
	},
	addPlayer: function(listNode){
		var teamEle = ftc.util.getEnclosingClass(listNode,'createTrade-form_team');
		if($(teamEle).hasClass('createTrade-form_team-myTeam')){
			if(this.myPlayerCount == 7){
				ftc.util.alert("Oops!","You can only have seven players per side.");
				return;
			}
			this.myPlayerCount++;
			new PlayerField(listNode,this,'mine');
		}else if($(teamEle).hasClass('createTrade-form_team-theirTeam')){
			if(this.theirPlayerCount == 7){
				ftc.util.alert("Oops!","You can only have seven players per side.");
				return;
			}
			this.theirPlayerCount++;	
			new PlayerField(listNode,this,'theirs');
		}
	}
}

function PlayerField(listNode,form,side){
	this.form = form;
	this.element = null;
	this.side = side;
	this.init(listNode);
	return this;
}
PlayerField.prototype = {
	init : function(listNode){
		this.element = this.constructElement();
		$(this.element).hide();
		listNode.appendChild(this.element);
		var $field = $('.createTrade-form_field',this.element);
		var sideClass = this.side == 'mine' ? '.createTrade-form_team-myTeam' : '.createTrade-form_team-theirTeam'
		var $select = $(sideClass+' .createTrade-form_field select').eq(0).clone();
		var $label = $(sideClass+' .createTrade-form_field label').eq(0).clone();
		var id = ftc.util.generateGuid();
		$select.attr('id',id);
		$label.attr('for',id);
		$field.append($label);
		$field.append($select);
		$(this.element).fadeIn('slow');
		this.attachEvents();
	},
	constructElement : function(){
		var li = document.createElement("li");
		li.innerHTML+= '<div class="createTrade-form_player-wrapLeft">'
		+						'<div class="createTrade-form_player-wrapRight">'
		+								'<div class="createTrade-form_player">'
		+								'<div class="createTrade-form_player-remove">remove</div>'
		+								'<div class="createTrade-form_field">'
		+								'</div>'
//		+								'<div class="createTrade-form_field">'
//		+ $('.createTrade-form_field')[1].innerHTML
//		+								'</div>'
		+							'</div>'
		+						'</div>'
		+					'</div>';
		return li;
	},
	attachEvents: function(){
		// $('.createTrade-form_field input',this.element).autocomplete('/players/findByName',{
		// 	maxItemsToShow:10,
		// 	autoFill:true,
		// 	delay:100,
		// 	extraParams:{league:$('.createTrade-form-field-league select').val()}
		// });
		
		var defaultValue = 'Enter player name...';
		$('.createTrade-form_field select',this.element).removeAttr('disabled');
    $('.createTrade-form_field select',this.element).ufd({
      skin:'sexy'
    });
    
    var $input = $('.createTrade-form_field input',this.element);
    $input.val(defaultValue);
    $input.css({color:'#999'})
    $input.focus(function(){
      $(this).css({color:'#000'});
      if($(this).val() == defaultValue){
        $(this).val('');
      }
    })

    
		// $('.createTrade-form_field input',this.element).blur(function(e){
		// 	e.preventDefault();
		//                         var s;
		//                         if(this.id.indexOf('_mine') > -1){
		//                             s = '_mine'
		// 		}else{
		//                             s = '_theirs'
		// 		}
		// 
		//                         var id = this.id.replace('-name'+s,'');
		//                         $(id+'-team'+s).attr("disabled","disabled");
		// 
		//                         ///////////////////////////////////////////////
		//                         // TODO:                                     //
		//                         // > ping server, look for that players team //
		//                         // > select the right team                   //
		//                         // > re- enable                              //
		//                         ///////////////////////////////////////////////
		// 
		//     });
	}
}

/*
 * TextLimit - jQuery plugin for counting and limiting characters for input and textarea fields
 * 
 * pass '-1' as speed if you don't want slow char deletion effect. (don't just put 0)
 * Example: jQuery("Textarea").textlimit('span.counter',256)
 *
 * $Version: 2007.10.24 +r1
 * Copyright (c) 2007 Yair Even-Or
 * vsync.design@gmail.com
 */
jQuery.fn.textlimit=function(counter_el, thelimit, speed) {
	var charDelSpeed = speed || 15;
	var toggleCharDel = speed != -1;
	var toggleTrim = true;
	
	var that = this[0];
	updateCounter();
	
	function updateCounter(){
		jQuery(counter_el).text(thelimit - that.value.length);
	};
	
	this.keypress (function(e){ if( this.value.length >= thelimit && e.charCode != '0' ) e.preventDefault() })
	.keyup (function(e){
		updateCounter();
		if( this.value.length >= thelimit && toggleTrim ){
			if(toggleCharDel){
				// first, trim the text a bit so the char trimming won't take forever
				that.value = that.value.substr(0,thelimit+100);
				var init = setInterval
					( 
						function(){ 
							if( that.value.length <= thelimit){ init = clearInterval(init); updateCounter() }
							else{ that.value = that.value.substring(0,that.value.length-1); jQuery(counter_el).text('trimming...  '+(thelimit - that.value.length)); };
						} ,charDelSpeed 
					);
			}
			else this.value = that.value.substr(0,thelimit);
		}
	});
	
};

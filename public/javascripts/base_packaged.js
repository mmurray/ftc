jQuery(function($){var csrf_token=$('meta[name=csrf-token]').attr('content'),csrf_param=$('meta[name=csrf-param]').attr('content');$.fn.extend({triggerAndReturn:function(name,data){var event=new $.Event(name);this.trigger(event,data);return event.result!==false;},callRemote:function(){var el=this,method=el.attr('method')||el.attr('data-method')||'GET',url=el.attr('action')||el.attr('href'),dataType=el.attr('data-type')||'script';if(url===undefined){throw"No URL specified for remote call (action or href must be present).";}else{if(el.triggerAndReturn('ajax:before')){var data=el.is('form')?el.serializeArray():[];$.ajax({url:url,data:data,dataType:dataType,type:method.toUpperCase(),beforeSend:function(xhr){el.trigger('ajax:loading',xhr);},success:function(data,status,xhr){el.trigger('ajax:success',[data,status,xhr]);},complete:function(xhr){el.trigger('ajax:complete',xhr);},error:function(xhr,status,error){el.trigger('ajax:failure',[xhr,status,error]);}});}
el.trigger('ajax:after');}}});$('a[data-confirm],input[data-confirm]').live('click',function(){var el=$(this);if(el.triggerAndReturn('confirm')){if(!confirm(el.attr('data-confirm'))){return false;}}});$('form[data-remote]').live('submit',function(e){$(this).callRemote();e.preventDefault();});$('a[data-remote],input[data-remote]').live('click',function(e){$(this).callRemote();e.preventDefault();});$('a[data-method]:not([data-remote])').live('click',function(e){var link=$(this),href=link.attr('href'),method=link.attr('data-method'),form=$('<form method="post" action="'+href+'"></form>'),metadata_input='<input name="_method" value="'+method+'" type="hidden" />';if(csrf_param!=null&&csrf_token!=null){metadata_input+='<input name="'+csrf_param+'" value="'+csrf_token+'" type="hidden" />';}
form.hide().append(metadata_input).appendTo('body');e.preventDefault();form.submit();});var disable_with_input_selector='input[data-disable-with]';var disable_with_form_remote_selector='form[data-remote]:has('+disable_with_input_selector+')';var disable_with_form_not_remote_selector='form:not([data-remote]):has('+disable_with_input_selector+')';var disable_with_input_function=function(){$(this).find(disable_with_input_selector).each(function(){var input=$(this);input.data('enable-with',input.val()).attr('value',input.attr('data-disable-with')).attr('disabled','disabled');});};$(disable_with_form_remote_selector).live('ajax:before',disable_with_input_function);$(disable_with_form_not_remote_selector).live('submit',disable_with_input_function);$(disable_with_form_remote_selector).live('ajax:complete',function(){$(this).find(disable_with_input_selector).each(function(){var input=$(this);input.removeAttr('disabled').val(input.data('enable-with'));});});});if(typeof ftc==="undefined"){ftc={};}
ftc.util={guids:{'00000000-0000-0000-0000-000000000001':true,'00000000-0000-0000-0000-000000000002':true},removeEnclosingElement:function(node,tagName){var ele=node;while(ele.tagName.toLowerCase()!=tagName.toLowerCase()){ele=ele.parentNode;}
$(ele).fadeOut("slow",function(){ele.parentNode.removeChild(ele);});},getEnclosingElement:function(node,tagName){var ele=node;while(ele.tagName.toLowerCase()!=tagName.toLowerCase()){ele=ele.parentNode;}
return ele;},getEnclosingClass:function(node,className){var ele=node;while(!$(ele).hasClass(className)){ele=ele.parentNode;}
return ele;},removeEnclosingClass:function(node,className){var ele=node;while(!$(ele).hasClass(className)){ele=ele.parentNode;}
$(ele).fadeOut("slow",function(){ele.parentNode.removeChild(ele);});},generateGuid:function(){var result,i,j;result="";while(!j||this.guids[result]){result="";for(j=0;j<32;j++){if(j==8||j==12||j==16||j==20){result=result+"-";}
i=Math.floor(Math.random()*16).toString(16).toUpperCase();result=result+i;}}
this.guids[result]=true;return result},alert:function(title,text){var div=document.createElement("div");$(div).html(text);document.body.appendChild(div);$(div).dialog({modal:true,title:title,buttons:{"Ok":function(){$(this).dialog("close");}}});},clone:function(object){function OneShotConstructor(){}
OneShotConstructor.prototype=object;return new OneShotConstructor();}};(function(){var initializing=false,fnTest=/xyz/.test(function(){xyz;})?/\b_super\b/:/.*/;this.Class=function(){};Class.extend=function(prop){var _super=this.prototype;initializing=true;var prototype=new this();initializing=false;for(var name in prop){prototype[name]=typeof prop[name]=="function"&&typeof _super[name]=="function"&&fnTest.test(prop[name])?(function(name,fn){return function(){var tmp=this._super;this._super=_super[name];var ret=fn.apply(this,arguments);this._super=tmp;return ret;};})(name,prop[name]):prop[name];}
function Class(){if(!initializing&&this.init)
this.init.apply(this,arguments);}
Class.prototype=prototype;Class.constructor=Class;Class.extend=arguments.callee;return Class;};})();(function($){var isLS=typeof window.localStorage!=='undefined'&&false;function wls(n,v){var c;if(typeof n==="string"&&typeof v==="string"){localStorage[n]=v;return true;}else if(typeof n==="object"&&typeof v==="undefined"){for(c in n){if(n.hasOwnProperty(c)){localStorage[c]=n[c];}}return true;}return false;}
function wc(n,v){var dt,e,c;dt=new Date();dt.setTime(dt.getTime()+31536000000);e="; expires="+dt.toGMTString();if(typeof n==="string"&&typeof v==="string"){document.cookie=n+"="+v+e+"; path=/";return true;}else if(typeof n==="object"&&typeof v==="undefined"){for(c in n){if(n.hasOwnProperty(c)){document.cookie=c+"="+n[c]+e+"; path=/";}}return true;}return false;}
function rls(n){return localStorage[n];}
function rc(n){var nn,ca,i,c;nn=n+"=";ca=document.cookie.split(';');for(i=0;i<ca.length;i++){c=ca[i];while(c.charAt(0)===' '){c=c.substring(1,c.length);}if(c.indexOf(nn)===0){return c.substring(nn.length,c.length);}}return null;}
function dls(n){return delete localStorage[n];}
function dc(n){return wc(n,"",-1);}
$.extend({Storage:{set:isLS?wls:wc,get:isLS?rls:rc,remove:isLS?dls:dc}});})(jQuery);$(document).ready(function(){$.each($('#system-message'),function(i,div){var $a=$('<a href="#" class="close">close</a>');$a.click(function(e){e.preventDefault();$(e.target.parentNode).fadeOut();});$(div).prepend($a);});$('.link-quickRegister').click(function(e){e.preventDefault();var dialog=new AjaxDialog({url:'/accounts/quickRegister',width:755,buttons:{"Close":function(){$(this).dialog("close");}}});});});$(document).ready(function(){$.each($('.tradeBox'),function(i,ele){new TradeBox(ele);});});function TradeBox(element){this.element;this.tradeId;this.init(element);return this;};TradeBox.prototype={init:function(element){this.element=element;this.id=element.id.replace('tradeBox-','');this.$results=$('.tradeBox-results',element);this.$buttons=$('.tradeBox-buttons',element);this.$loading=$("<p class='loading'>Sending your vote...</p>");this.attachEvents();return this;},attachEvents:function(){var _self=this;$(this.element).delegate('.tradeBox-voteButton-yes','click',function(e){e.preventDefault();_self.doVote('true');});$(this.element).delegate('.tradeBox-voteButton-no','click',function(e){e.preventDefault();_self.doVote('false');});},doVote:function(vote){this.$buttons.replaceWith(this.$loading);var _self=this;$.ajax({type:'post',url:'/trades/vote/'+this.id+'.json',data:{"do_it":vote},success:function(data){_self.handleVoteResponse.call(_self,data,vote);}});},handleVoteResponse:function(data,vote){var $text=$('span',this.$results);var $icon=$('.tradeBox-icon',this.$results);$text.fadeOut();var label=data.trade.do_it?"I'd do it!":"Forget it";$text.html(data.trade.percent+'% say "'+label+'"');$text.fadeIn();if(data.trade.do_it){$icon.removeClass('down').addClass('up');}else{$icon.removeClass('up').addClass('down');}
var answerDiv=document.createElement("div");$(answerDiv).attr('class','tradeBox-vote-answer tradeBox-vote-answer-'+vote).html("<span class='ico'></span><span class='label'>You said \""+label+"\"</span>");this.$loading.replaceWith(answerDiv);}};
/** ftc 'main' javascript
 * copyright (c) 2009 fantasytradecritic.com
 * @author mike murray
 * @website http://murz.net
 */

$(document).ready(function(){
	
	$.each($('#system-message'),function(i,div){
	  var $a = $('<a href="#" class="close">close</a>');
	  $a.click(function(e){
	    e.preventDefault();
      $(e.target.parentNode).fadeOut();
	  });
	  $(div).prepend($a);
	});
	
	$('.link-quickRegister').click(function(e){
		e.preventDefault();
		var dialog = new AjaxDialog({
			url:'/accounts/quickRegister',
			width:755,
			buttons: {
				"Close": function(){
					$(this).dialog("close");
				}
			}
		});
	});
});


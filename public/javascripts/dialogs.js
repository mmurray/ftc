/** ftc 'dialogs' javascript
 * copyright (c) 2009 fantasytradecritic.com
 * @author mike murray
 * @website http://murz.net
 */

var Dialog = Class.extend({
	init: function(options){
		this.settings = options;
		if (!this.settings)
			this.settings = {};
		if (!this.settings.element) {
			this.settings.element = document.createElement("div");
			document.body.appendChild(this.settings.element);
		}
		if (!this.settings.modal) 
			this.settings.modal = true;
		if (!this.settings.title) 
			this.settings.title = "";
		if (!this.settings.body)
			this.settings.body = "";
		if (!this.settings.width)
			this.settings.width = 420;
		if (!this.settings.buttons) {
			this.settings.buttons = {
				"Ok": function(){
					$(this).dialog("close");
				}
			};
		}
		
		$(this.settings.element).html(this.settings.body);
		
		$(this.settings.element).dialog({
			modal:this.settings.modal,
			title:this.settings.title,
			buttons:this.settings.buttons,
			width:this.settings.width
		});
		
		this.attachEvents();
		return this;
	},
	setBody: function(html){
		$('.ui-dialog-content').html(html);
	},
	attachEvents: function(){
		var _self = this;
		
	}
});

var AjaxDialog = Dialog.extend({
	init: function(options){
		this.settings = options;
		var _self = this;
		if (!this.settings) 
			this.settings = {};
		if (!this.settings.url) 
			throw 'AjaxDialog requires a url';
		$.get(this.settings.url, function(data, status){
			if (status == 'success') {
				_self.setBody(data);
			}
		});
		this.settings.body = "<p class='loading'>Loading...</p>";
		return this._super(options);
	}
});



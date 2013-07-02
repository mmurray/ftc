/** ftc 'util' javascript
 * copyright (c) 2009 fantasytradecritic.com
 * @author mike murray
 * @website http://murz.net
 */

if(typeof ftc === "undefined"){
	ftc = {};
}


ftc.util = {
	guids : {'00000000-0000-0000-0000-000000000001': true,
			'00000000-0000-0000-0000-000000000002': true},
	removeEnclosingElement:function(node,tagName){
		var ele = node;
		while(ele.tagName.toLowerCase() != tagName.toLowerCase()){
			ele = ele.parentNode;
		}
		$(ele).fadeOut("slow",function(){
			ele.parentNode.removeChild(ele);
		});
	},
	getEnclosingElement:function(node,tagName){
		var ele = node;
		while(ele.tagName.toLowerCase() != tagName.toLowerCase()){
			ele = ele.parentNode;
		}
		return ele;
	},
	getEnclosingClass:function(node,className){
		var ele = node;
		while(!$(ele).hasClass(className)){
			ele = ele.parentNode;
		}
		return ele;
	},
	removeEnclosingClass:function(node,className){
		var ele = node;
		while(!$(ele).hasClass(className)){
			ele = ele.parentNode;
		}
		$(ele).fadeOut("slow",function(){
			ele.parentNode.removeChild(ele);
		});
	},
	generateGuid : function () {
	   var result, i, j;
	   result = "";
	   while (!j || this.guids[result]) {
	     result = "";
	     for(j=0; j<32; j++){
	       if( j == 8 || j == 12|| j == 16|| j == 20) { result = result + "-"; }
	       i = Math.floor(Math.random()*16).toString(16).toUpperCase();
	       result = result + i;
	     }
	   }
	
	   //Add the GUID to our master index
	   this.guids[result] = true;
	   return result
	},
	alert : function (title,text) {
		var div = document.createElement("div");
		$(div).html(text);
		document.body.appendChild(div);
		$(div).dialog({
			modal:true,
			title:title,
			buttons: {
				"Ok": function(){
					$(this).dialog("close");
				}
			}
		});
	},
	clone : function (object) {
	  function OneShotConstructor(){}
	  OneShotConstructor.prototype = object;
	  return new OneShotConstructor();
	}
};


//oop
(function(){
  var initializing = false, fnTest = /xyz/.test(function(){xyz;}) ? /\b_super\b/ : /.*/;

  // The base Class implementation (does nothing)
  this.Class = function(){};
 
  // Create a new Class that inherits from this class
  Class.extend = function(prop) {
    var _super = this.prototype;
   
    // Instantiate a base class (but only create the instance,
    // don't run the init constructor)
    initializing = true;
    var prototype = new this();
    initializing = false;
   
    // Copy the properties over onto the new prototype
    for (var name in prop) {
      // Check if we're overwriting an existing function
      prototype[name] = typeof prop[name] == "function" &&
        typeof _super[name] == "function" && fnTest.test(prop[name]) ?
        (function(name, fn){
          return function() {
            var tmp = this._super;
           
            // Add a new ._super() method that is the same method
            // but on the super-class
            this._super = _super[name];
           
            // The method only need to be bound temporarily, so we
            // remove it when we're done executing
            var ret = fn.apply(this, arguments);       
            this._super = tmp;
           
            return ret;
          };
        })(name, prop[name]) :
        prop[name];
    }
   
    // The dummy class constructor
    function Class() {
      // All construction is actually done in the init method
      if ( !initializing && this.init )
        this.init.apply(this, arguments);
    }
   
    // Populate our constructed prototype object
    Class.prototype = prototype;
   
    // Enforce the constructor to be what we expect
    Class.constructor = Class;

    // And make this class extendable
    Class.extend = arguments.callee;
   
    return Class;
  };
})();

//storage
(function($) {
  // Private data
  var isLS=typeof window.localStorage!=='undefined' && false;
  // Private functions
  function wls(n,v){var c;if(typeof n==="string"&&typeof v==="string"){localStorage[n]=v;return true;}else if(typeof n==="object"&&typeof v==="undefined"){for(c in n){if(n.hasOwnProperty(c)){localStorage[c]=n[c];}}return true;}return false;}
  function wc(n,v){var dt,e,c;dt=new Date();dt.setTime(dt.getTime()+31536000000);e="; expires="+dt.toGMTString();if(typeof n==="string"&&typeof v==="string"){document.cookie=n+"="+v+e+"; path=/";return true;}else if(typeof n==="object"&&typeof v==="undefined"){for(c in n) {if(n.hasOwnProperty(c)){document.cookie=c+"="+n[c]+e+"; path=/";}}return true;}return false;}
  function rls(n){return localStorage[n];}
  function rc(n){var nn, ca, i, c;nn=n+"=";ca=document.cookie.split(';');for(i=0;i<ca.length;i++){c=ca[i];while(c.charAt(0)===' '){c=c.substring(1,c.length);}if(c.indexOf(nn)===0){return c.substring(nn.length,c.length);}}return null;}
  function dls(n){return delete localStorage[n];}
  function dc(n){return wc(n,"",-1);}

  /**
  * Public API
  * $.Storage - Represents the user's data store, whether it's cookies or local storage.
  * $.Storage.set("name", "value") - Stores a named value in the data store.
  * $.Storage.set({"name1":"value1", "name2":"value2", etc}) - Stores multiple name/value pairs in the data store.
  * $.Storage.get("name") - Retrieves the value of the given name from the data store.
  * $.Storage.remove("name") - Permanently deletes the name/value pair from the data store.
  */
  $.extend({
    Storage: {
      set: isLS ? wls : wc,
      get: isLS ? rls : rc,
      remove: isLS ? dls :dc
    }
  });
})(jQuery);

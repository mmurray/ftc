class ApplicationController < ActionController::Base
  protect_from_forgery
  helper_method :nav
  before_filter :checkUsername
  
  def nav
    val = defined?(@nav) ? @nav : "home"
    val = params[:id] if(params[:controller] == 'pages')
    return val
  end
  
  def checkUsername
    if user_signed_in? && !current_user.has_username && params[:controller] != 'usernames' && !(params[:controller] == 'devise/sessions' && params[:action] == 'destroy')
      redirect_to '/usernames/new'
    end
  end
  
  def set_vote_cookie(trade_id, do_it)
    if(cookies[:snbatv] == nil)
      cookies[:snbatv] = trade_id.to_s+'='+do_it.to_s
    else
      isset = false
      result = Array.new
      pairs = cookies[:snbatv].split(',')
      pairs.each do |pair|
        pieces = pair.split('=')
        if(pieces[0].to_s == trade_id.to_s)
          result << pieces[0]+'='+do_it
          isset = true
        else
          result << pair
        end
      end
      if(!isset)
        result << trade_id + '=' + do_it
      end
      cookies[:snbatv] = result.join(',')
    end
  end

  
end

class UsernamesController < ApplicationController
  
  def new
    @user = current_user
  end
  
  def update
    @user = current_user
    @user.username = params[:user][:username]
    @user.has_username = true
    if @user.save
      redirect_to '/'
    else
      render :action => "new"
    end
  end
  
end

class AvatarsController < ApplicationController
  def upload
    @user = current_user
  end
  
end

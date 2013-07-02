class WelcomeController < ApplicationController
  
  respond_to :html
  
  def index
    @trades = Trade.all
  end
  
  def absorb_nfl
  end
  
  def contact_form
    @nav = 'contact'
  end
  
  def send_contact_form
    @nav = 'contact'
    @contact = Contact.new(params[:contact])
    if @contact.save
      begin
        ContactMailer.deliver_message_from_visitor(@contact)
        flash[:notice] = "Your message has been sent"
        redirect_to '/'
      rescue
        flash[:notice] = "Sorry, an error occured while sending your message"
        redirect_to '/'
      end
    end
  end
  
end
class ContactMailer < ActionMailer::Base
  def message_from_visitor(contact)
    @subject = "[FTC] Email sent via contact form"
    @body['message'] = "Name: "+contact.name+"\n\n"+contact.message
    @recipients = "jkrich@gmail.com, mmurray.wa@gmail.com"
    @from = contact.email
    @sent_on = Time.now
    @headers = {}
  end
end

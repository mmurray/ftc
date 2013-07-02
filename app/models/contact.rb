class Contact < Tableless
  column :email, :string
  column :message, :text
  column :name, :string
  validates_presence_of :message
  validates_presence_of :email
  validates_presence_of :name
  validates_format_of :email, :with => /^([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})$/i, :message => "is invalid"
end
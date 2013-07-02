class MyPlayer < ActiveRecord::Base
  belongs_to :player
  belongs_to :trade
end

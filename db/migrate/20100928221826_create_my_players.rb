class CreateMyPlayers < ActiveRecord::Migration
  def self.up
    create_table :my_players, :id=>false do |t|
      t.references :player
      t.references :trade
    end
  end

  def self.down
    drop_table :my_players
  end
end

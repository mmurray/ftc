class CreateTheirPlayers < ActiveRecord::Migration
  def self.up
    create_table :their_players, :id=>false do |t|
      t.references :player
      t.references :trade
    end
  end

  def self.down
    drop_table :their_players
  end
end

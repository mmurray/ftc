class CreateLeagues < ActiveRecord::Migration
  def self.up
    create_table :leagues do |t|
      t.string :name
      t.string :sport
      t.string :abbreviation

      t.timestamps
    end
  end

  def self.down
    drop_table :leagues
  end
end

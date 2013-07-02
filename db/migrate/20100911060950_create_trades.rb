class CreateTrades < ActiveRecord::Migration
  def self.up
    create_table :trades do |t|
      t.text :comment
      t.references :league
      t.references :user
      t.integer :views, :default=>0
      t.integer :percent, :default=>0
      t.integer :for_votes, :default=>0
      t.integer :against_votes, :default=>0
      t.integer :total_votes, :default=>0
      t.boolean :do_it, :default=>true
      t.boolean :is_active, :default=>true

      t.timestamps
    end
  end

  def self.down
    drop_table :trades
  end
end

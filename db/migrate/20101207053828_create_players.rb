class CreatePlayers < ActiveRecord::Migration
  def self.up
    create_table :players do |t|
      t.integer:twitter_id
      t.string :name
      t.string :twitter_name
      t.integer :team_id
      t.boolean :processed, :default => false
      t.timestamps
    end
  end

  def self.down
    drop_table :players
  end
end

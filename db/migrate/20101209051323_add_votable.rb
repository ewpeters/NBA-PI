class AddVotable < ActiveRecord::Migration
  def self.up
    create_table :votables do |t|
      t.string :twitter_name
      t.string :twitter_id
      t.integer :yay
      t.ingeger :nay
      t.timestamps
    end
  end

  def self.down
    drop_table :teams
  end
end

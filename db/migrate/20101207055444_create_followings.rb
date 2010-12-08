class CreateFollowings < ActiveRecord::Migration
  def self.up
    create_table :followings do |t|
      t.integer :woman_id
      t.integer :player_id
      t.timestamps
    end
  end

  def self.down
    drop_table :followings
  end
end

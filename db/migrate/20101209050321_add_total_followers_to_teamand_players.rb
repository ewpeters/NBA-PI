class AddTotalFollowersToTeamandPlayers < ActiveRecord::Migration
  def self.up
    add_column :players, :total_followers, :integer
  end

  def self.down
  end
end

class CreateWomen < ActiveRecord::Migration
  def self.up
    create_table :women do |t|
      t.integer :twitter_id
      t.string :name
      t.string :twitter_name
      t.timestamps
    end
  end

  def self.down
    drop_table :women
  end
end

class Player < ActiveRecord::Base
  has_many :followings
  has_many :players, :through => :followings
  belongs_to :team
  
  def self.walk_twitter
    keywords = ["babe", "candy", "princess", "model", "chick", "girl", "lady"]
  end
  
  def picture
    if self.twitter_id.nil?
      "http://api.twitter.com/1/users/profile_image/twitter.json?size=normal"
    else
      "http://api.twitter.com/1/users/profile_image/#{self.twitter_id}.json?size=normal"
    end
  end
  
  def self.walk_twitter
    keywords = ["babe", "candy", "princess", "model", "chick", "girl", "lady"]
    User.all.each do |user|
      if !user.processed
        process_user(user)
      end
    end
  end
  
  private
  def self.process_user(user)
    keywords = ["babe", "sex" "candy", "goddess", "actress", "hostess", "woman", "princess", "model", "chick", "girl", "lady", "booking", "vixen", "bikini", "porn", "dancer", "massage"]
    cursor = -1
    while cursor != 0
      Twitter.friends(user.twitter_name, :cursor => cursor).users.each do |follower|
        if !follower.verified
          name = follower.name.downcase
          desc = follower.description.downcase
          if keywords.any? {|str| name.downcase.include?(str) || name.downcase.include?(str) }
            woman = Woman.find_or_create_by_twitter_id(follower.id)
            woman.name = follower.name
            woman.save
            user.women << woman
            user.save
          end
        end
      end
    end
  end
end

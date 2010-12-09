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
    Player.all.each do |user|
      if !user.processed
        user.process_user
      end
    end
  end
  

  def process_user
    keywords = ["babe", "sex" "candy", "goddess", "actress", "hostess", "woman", "princess", "model", "chick", "girl", "lady", "booking", "vixen", "bikini", "porn", "dancer", "massage"]
    cursor = -1
    while cursor != 0
      twitter_request = Twitter.friends(self.twitter_name, :cursor => cursor)
      twitter_request.users.each do |follower|
        if !follower.verified
          name = follower.name.downcase
          desc = follower.description.downcase
          if keywords.any? {|str| name.downcase.include?(str) || name.downcase.include?(str) }
            woman = Woman.find_or_create_by_twitter_id(follower.id)
            woman.name = follower.name
            woman.save
            self.women << woman
            self.save
          end
        end
      end
      cursor = twitter_request.next_cursor
    end
  end
end

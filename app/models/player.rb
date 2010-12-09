class Player < ActiveRecord::Base
  has_many :followings
  has_many :women, :through => :followings
  belongs_to :team
  
  def picture
    if self.twitter_id.nil?
      "http://api.twitter.com/1/users/profile_image/twitter.json?size=normal"
    else
      "http://api.twitter.com/1/users/profile_image/#{self.twitter_id}.json?size=normal"
    end
  end
  
  def self.walk_twitter
    non_names = ["miss", "babe", "sex",
"candy", "goddess", "actress", "hostess", "woman", 
"princess", "model", "chick", "girl", "lady", "booking", 
"vixen", "bikini", "porn", "dancer", "massage", "cute", "naked", "singer", "pretty",
"socialite"]
    names = []
    file = File.open("#{Rails.root}/women", 'r')
    puts names.size
    while (line = file.gets)
      names << line.split(' ').first.downcase
    end
    keywords = names + non_names
    Player.all.each do |user|
      if !user.processed
        begin
          user.process_user(keywords)
        rescue          
        end
      end
    end
  end
  

  def process_user(keywords)
    cursor = -1
    while cursor != 0
      twitter_request = Twitter.friends(self.twitter_name, :cursor => cursor)
      twitter_request.users.each do |follower|
        if !follower.verified
          name = follower.name || ""
          desc = follower.description | ""
          Votable.find_or_create_by_twitter_id_and_twitter_name(:twitter_name => name, :twitter_id => follower.id)
          if keywords.any? {|str| name.downcase.include?(str) || desc.downcase.include?(str) }
            woman = Woman.find_or_create_by_twitter_id(follower.id)
            woman.name = follower.name
            woman.save
            self.women << woman
          end
        end
        self.total_followers += 1
        self.save
      end
      cursor = twitter_request.next_cursor
    end
    self.processed = true;
    self.save
  end
end

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
    Player.all.each do |user|
      if !user.processed
        user.process_user(names, non_names)
      end
    end
  end
  

  def process_user(names, keywords)
    cursor = -1
    total_users = 0
    while cursor != 0
      begin
      twitter_request = Twitter.friends(self.twitter_name, :cursor => cursor)
      rescue
       cursor = 0
       return
      end
      twitter_request.users.each do |follower|
        if !follower.verified
          name        = follower.name || ""
          screen_name = follower.screen_name || ""
          desc = follower.description || ""
          Votable.find_or_create_by_twitter_id_and_twitter_name(:twitter_name => name, :twitter_id => follower.id)
          if is_in_names(name, names) || keywords.any? {|str| screen_name.downcase.include?(str) || desc.downcase.include?(str) }
            woman = Woman.find_or_create_by_twitter_id(follower.id)
            woman.name = follower.name
            woman.save
            self.women << woman
          end
        end
        total_users += 1
        self.save
      end
      cursor = twitter_request.next_cursor
    end
    self.processed = true;
    self.total_followers = total_users
    self.save
  end
  
  private
  def is_in_names(str, names)
    str.split(' ').each do |a|
      if a.downcase.member?(names)
        return true
      end
    end
    return false
  end
end

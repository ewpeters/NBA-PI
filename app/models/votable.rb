class Votable < ActiveRecord::Base
  def picture
    if self.twitter_id.nil?
      "http://api.twitter.com/1/users/profile_image/twitter.json?size=normal"
    else
      "http://api.twitter.com/1/users/profile_image/#{self.twitter_id}.json?size=normal"
    end
  end
end
